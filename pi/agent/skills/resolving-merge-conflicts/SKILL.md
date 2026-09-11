---
name: resolving-merge-conflicts
description: Resolve an in-progress Git merge or rebase conflict without losing either change's intent. Invoke with /skill:resolving-merge-conflicts.
disable-model-invocation: true
---

# Resolving merge conflicts

Resolve conflicts by reconciling the intent behind both changes, not by choosing a side mechanically.

## Establish the state

Inspect the current merge or rebase, the branch history, and every conflicted file. Identify the operation in progress and the commits it joins before editing a hunk.

## Recover intent

For each conflict, trace both changes to their source. Read commit messages, pull requests, linked issues, relevant code, and tests. Establish what each change was meant to preserve or alter.

## Reconcile each hunk

Keep both intents when they are compatible. When they conflict, choose the behavior that fits the merge or rebase goal and record the trade-off. Do not invent behavior merely to make markers disappear.

Resolve the in-progress operation rather than abandoning it to avoid the work. If the changes cannot be safely reconciled from the available evidence, stop and explain the decision that needs an owner.

## Verify and finish

Find the repository's normal checks and run the relevant type checks, tests, and formatter. Fix regressions caused by the resolution.

Confirm there are no remaining conflict markers or unmerged paths. Stage the resolution and complete the merge. For a rebase, continue until every commit has applied. Report the resolved files, checks run, and any trade-offs.
