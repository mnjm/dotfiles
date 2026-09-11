---
name: show-me-your-work
description: Keep a concise, reviewable decision trail for long-running, multi-phase, or unattended work. Invoke with /skill:show-me-your-work.
disable-model-invocation: true
---

# Show me your work

Keep a decision trail when a reviewer needs to understand and trust work they did not watch happen. The trail records what was decided, why, the evidence, and the result. It is not an activity log.

## Keep one log

Use one append-only TSV file for the effort. Store it as `decisions.tsv` in the work directory, or `.audit/<task>.tsv` when several efforts need separate logs. Keep it local unless the reviewer needs it in version control.

Start with this header:

```tsv
ts	phase	decision	why	evidence	result
```

Each field stays on one line.

- `ts`: ISO 8601 timestamp.
- `phase`: the workstream or stage.
- `decision`: what was done or chosen.
- `why`: the reason in plain language.
- `evidence`: a pointer to proof, such as a commit, file and line, test output, trace, screenshot, or artifact.
- `result`: the observed outcome or current state.

Escape or remove tabs and newlines before appending. Prefix spreadsheet-formula-like cell values that start with `=`, `+`, `-`, or `@` with a single quote.

## What to record

Log meaningful decisions and checkpoints: a fork chosen, a completed unit with its verification result, a pivot or revert and its trigger, a blocker, or a failed gate. For repeated work, log each iteration. Skip routine commands and claims a reviewer cannot audit.

Write each row as a concrete statement. Evidence points to the proof. It does not replace it with a paragraph. If a decision cannot fit on one line, make it more precise.

Do not rewrite history. Add a new row to correct, supersede, or reverse an earlier decision.

## Verify the trail

Before handing work over, compare the log with the actual work record and artifacts.

- Remove claims that did not happen.
- Check that every evidence pointer resolves and supports the row.
- Add material pivots, abandoned approaches, and missing verification results.
- Cut rows that add no review value.

When independent review is available, ask a fresh reviewer to inspect the trail and the evidence for weak proof, skipped verification, risky choices, and gaps. Report the concrete flags, or state that no flags were found.

## Hand off

Tell the reviewer where the log is. For a committed log, make it easy to inspect as a table. The log should let them follow the important decisions without reading the whole work transcript.
