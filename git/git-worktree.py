#!/usr/bin/env python3
"""Create, remove, and list repository worktrees."""

from __future__ import annotations

import re
import shutil
import subprocess
import sys
from pathlib import Path


FILES_LIST = "worktree-files.list"


def usage() -> None:
    print(f"Usage: {Path(sys.argv[0]).name} {{add|remove|list}} [branch-or-ref-or-path] [--force|-f (remove only)]", file=sys.stderr)
    raise SystemExit(1)


def git_output(*args: str, cwd: Path | None = None) -> str:
    return subprocess.check_output(["git", *args], cwd=cwd, text=True).strip()


def repository_root() -> Path:
    try:
        return Path(git_output("rev-parse", "--show-toplevel")).resolve()
    except subprocess.CalledProcessError:
        print("git-worktree.py must run inside a Git working tree", file=sys.stderr)
        raise SystemExit(1)


def worktree_path(root: Path, ref: str) -> Path:
    return root.parent / f"{root.name}-{ref.replace('/', '-')}"


def listed_files(root: Path) -> list[tuple[Path, Path]]:
    files_list = root / FILES_LIST
    if not files_list.exists():
        return []

    files: list[tuple[Path, Path]] = []
    for line_number, line in enumerate(files_list.read_text().splitlines(), start=1):
        pattern = line.strip()
        if not pattern or pattern.startswith("#"):
            continue

        try:
            regex = re.compile(pattern)
        except re.error as error:
            raise ValueError(f"{FILES_LIST}:{line_number}: invalid regex: {pattern}") from error

        for source in root.rglob("*"):
            if source.is_file() and regex.fullmatch(source.relative_to(root).as_posix()):
                files.append((source, source.relative_to(root)))
    return files


def add(root: Path, ref: str) -> None:
    destination = worktree_path(root, ref)
    try:
        files = listed_files(root)
    except ValueError as error:
        print(error, file=sys.stderr)
        raise SystemExit(1)

    subprocess.run(["git", "worktree", "add", str(destination), ref], cwd=root, check=True)
    try:
        for source, relative in files:
            if not source.is_file():
                continue
            target = destination / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, target)
    except Exception:
        subprocess.run(["git", "worktree", "remove", "--force", str(destination)], cwd=root, check=False)
        raise


def remove(root: Path, ref: str, force: bool = False) -> None:
    worktrees = git_output("worktree", "list", "--porcelain", "-z", cwd=root)
    records = [record.split("\0") for record in worktrees.split("\0\0") if record]
    main_root = Path(records[0][0].removeprefix("worktree "))
    destination = worktree_path(main_root, ref)
    explicit_path = Path(ref).resolve()
    branch = ref if ref.startswith("refs/heads/") else f"refs/heads/{ref}"
    destination_fields = next(
        (fields for fields in records if fields[0] == f"worktree {explicit_path}"),
        None,
    )
    if destination_fields is None:
        destination_fields = next(
            (fields for fields in records if f"branch {branch}" in fields),
            None,
        )
    if destination_fields is None:
        destination_fields = next(
            (fields for fields in records if fields[0] == f"worktree {destination}"),
            None,
        )
    if destination_fields is None:
        revision = subprocess.run(
            ["git", "rev-parse", "--verify", "--quiet", f"{ref}^{{commit}}"],
            cwd=root, text=True, capture_output=True,
        )
        if revision.returncode == 0:
            matches = [fields for fields in records if f"HEAD {revision.stdout.strip()}" in fields]
            if len(matches) > 1:
                print(f"Multiple worktrees match {ref}; specify a worktree path:", file=sys.stderr)
                for fields in matches:
                    print(fields[0].removeprefix("worktree "), file=sys.stderr)
                raise SystemExit(1)
            if matches:
                destination_fields = matches[0]
    if destination_fields is not None:
        destination = Path(destination_fields[0].removeprefix("worktree "))

    if force:
        locked = any(field == "locked" or field.startswith("locked ") for field in destination_fields or [])
        if destination_fields is None or (
            destination_fields is not records[0] and not (destination / ".git").exists() and not locked
        ):
            if destination.is_symlink():
                destination.unlink()
            elif destination.exists():
                shutil.rmtree(destination)
            if destination_fields is None:
                return

    args = ["git", "worktree", "remove"]
    if force:
        args.append("--force")
    subprocess.run([*args, str(destination)], cwd=root, check=True)


def main() -> None:
    if len(sys.argv) < 2 or sys.argv[1] not in {"add", "remove", "list"}:
        usage()

    command = sys.argv[1]
    if command == "list":
        if len(sys.argv) != 2:
            usage()
        subprocess.run(["git", "worktree", "list"], check=True)
        return

    refs = sys.argv[2:]
    force = command == "remove" and any(arg in {"--force", "-f"} for arg in refs)
    if force:
        refs = [arg for arg in refs if arg not in {"--force", "-f"}]
    if len(refs) != 1 or not refs[0] or refs[0].startswith("-"):
        usage()

    root = repository_root()
    if command == "add":
        add(root, refs[0])
    else:
        remove(root, refs[0], force=force)


if __name__ == "__main__":
    try:
        main()
    except subprocess.CalledProcessError as error:
        raise SystemExit(error.returncode)
