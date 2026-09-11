---
name: commit
description: Inspect Git changes, choose the intended commit contents, and create a commit message that follows the repository's last ten commits.
disable-model-invocation: true
---
# Commit

Create a focused commit

1. Inspect

git status --short
git diff --cached --name-status
git diff --name-status
git diff --cached
git diff
git log -10 --format='%B%n---'

Identify: staged, unstaged, untracked

2. Stage

- If staged + unstaged: ask to stage unstaged. Stage all or only requested files.
- If only unstaged: stage all.
- Never stage untracked unless asked.

Re-check with: git diff --cached, git status --short

3. Commit message

- Infer format, prefix, tense, body, and level of detail from the last 10 commits.
- When recent commits use detailed bodies, include a concise summary plus matching sectioned detail, such as `### Key Changes:` and file-specific bullets.
- Write the message based only on staged changes and the code around it. Ask if anything is ambiguous.
- Pass multiline messages with actual newline characters. Use separate `-m` arguments for the subject and body, or `git commit -F - <<'EOF'` with a heredoc. Never put literal `\\n` sequences in a commit message.

4. Commit & report

git commit
git show --stat --oneline HEAD
git status --short
