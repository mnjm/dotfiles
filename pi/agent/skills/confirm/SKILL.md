---
name: confirm
description: Plan a requested change and wait for the user's explicit approval before making edits. Use when the user asks to confirm a plan or invokes /skill:confirm.
---

# Confirm

Do not make changes before approval.

If no request was given, ask what to plan. Inspect the codebase only as needed.

Give a short plan with affected files, intended behavior, and checks. State material assumptions or risks. Ask for approval.

Only explicit approval, such as "approve", "proceed", or "do it", permits implementation. Otherwise, revise the plan from the user's feedback and ask again.
