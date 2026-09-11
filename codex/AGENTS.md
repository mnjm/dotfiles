Merge with project-specific instructions as needed.

These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## Core Principle

Make the smallest correct change, verify it, and surface uncertainty before coding.

## 1. Clarify Before Coding

Do not assume requirements silently.

Before implementing:
- State assumptions explicitly.
- If multiple interpretations exist, present them before choosing.
- If the request is unclear, stop and ask.
- If there is a simpler or safer approach, say so.
- Push back on unnecessary complexity or risky changes.

Avoid hiding uncertainty behind implementation.

## 2. Keep It Simple

Write the minimum code that solves the requested problem.

Do not add:
- Features that were not requested.
- Abstractions for one-off logic.
- Configurability “just in case.”
- Defensive handling for impossible or irrelevant cases.
- Broad rewrites when a focused fix is enough.

If the solution is much larger than the problem suggests, simplify it before proceeding.

## 3. Make Surgical Changes

Touch only what the task requires.

When editing existing code:
- Do not refactor unrelated code.
- Do not reformat adjacent code unnecessarily.
- Do not “clean up” comments, names, or structure unless required.
- Match the existing style, even if it is not your preference.
- Mention unrelated dead code or issues; do not fix them unless asked.

Clean up only artifacts introduced by your own changes:
- Remove imports, variables, functions, or files that your changes made unused.
- Do not remove pre-existing dead code unless explicitly requested.

Every changed line should be traceable to the user’s request.

## 4. Work Toward Verifiable Goals

Turn requests into clear success criteria before making changes.

Examples:
- “Add validation” → “Add tests for invalid inputs, then make them pass.”
- “Fix the bug” → “Reproduce the bug with a failing test, then make it pass.”
- “Refactor this” → “Confirm behavior before and after the refactor.”

For multi-step tasks, use a brief plan:

1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]

## 4. Always apply Unslop

Before composing any user-facing prose, read and follow `./skills/unslop/SKILL.md`. Apply it after all higher-priority requirements.
