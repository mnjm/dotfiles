---
name: how
description: Explain how a codebase subsystem, feature flow, module, or runtime path works. Use for code walkthroughs, ownership and layering questions, and architecture critiques. Invoke with /skill:how.
disable-model-invocation: true
---

# How

Answer "how does this work?" by building an evidence-based mental model of the code. Explain the design and runtime flow well enough for an engineer to change it safely. Do not turn the answer into a line-by-line tour.

## Scope

Decide what the question asks for: a module, a feature flow, an architectural overview, a runtime trace, or where responsibility belongs.

If the request has more than one plausible meaning, state the interpretation you are using, then investigate. Do not make claims from names, comments, or directory layout alone. Read the code that carries the behavior.

## Investigate

Start at an entry point, public API, event, request handler, or visible output. Trace the real path through callers, callees, data, decisions, state changes, and side effects.

Read definitions and relevant tests or configuration when they affect the answer. Keep going until you can account for the path from trigger to result without a gap. Record the files and symbols that support each important claim.

For a narrow question, investigate and explain directly. For a broad subsystem, split the work into a few non-overlapping questions, such as state, request flow, and configuration. Investigate them independently when parallel read-only investigation is available, then reconcile the results before writing.

Call out surprises, invariants, failure paths, and historical-looking code that changes how a reader should reason about the system. If the code does not establish something, say so.

## Explain

Adapt the answer to the question. Usually include:

- **Overview.** What this part does and its boundary.
- **Key concepts.** Only the types, services, or abstractions needed to follow the explanation.
- **Flow.** Trigger, steps, data movement, decision points, and effect. Name the relevant files and symbols.
- **Code map.** The few places a reader should open first.
- **Gotchas.** Non-obvious behavior, constraints, failure modes, or sharp edges.

Use prose for the flow. Include code only when a small excerpt resolves an ambiguity. Separate facts from inference. Prefer precise file references over vague descriptions.

## Critique

When asked for architectural problems or improvements, explain the system first. A critique without a working model is guesswork.

Then assess concrete findings against the code. Judge each one rather than collecting opinions:

- **Act on:** a clear problem worth fixing now.
- **Consider:** a real trade-off with an uncertain payoff.
- **Noted:** true, but low priority.
- **Dismissed:** unsupported, missing context, or a style preference.

Present the explanation before the critique so the reader can evaluate the judgment.
