---
name: improve-codebase-architecture
description: Find concrete architecture refactors that make code easier to change and test, present ranked candidates in an HTML report, then examine a selected candidate. Invoke with /skill:improve-codebase-architecture.
disable-model-invocation: true
---

# Improve codebase architecture

Find refactors that concentrate complexity behind simpler interfaces. Focus on real friction, not an inventory of theoretical cleanups.

## Scope the review

Start with a user-named subsystem or pain point. Otherwise, inspect recent history and prioritize code that changes often. Widen the search only when history shows no clear hot spot.

Read nearby project context and architecture decision records before judging a design. Use the domain's own names. Treat existing decisions as constraints unless observed friction gives a concrete reason to revisit one.

## Find candidates

Trace real behavior through the code. Look for cases where understanding one concept requires crossing many thin modules, an interface exposes nearly as much complexity as its implementation, dependencies leak across a seam, or tests exercise helpers but miss the behavior that fails in production.

For a suspected shallow module, apply the deletion test: if deleting it would merely move its complexity elsewhere, it is not a useful target. Prefer candidates where consolidation would put related behavior in one place and give callers a smaller, more stable interface.

Do not design a replacement interface or change code yet. Produce only enough evidence to compare candidates.

## Present the review

Load and follow the [HTML report workflow](../html-report/SKILL.md). Write a fresh report to the operating system's temporary directory.

Give each candidate a compact card with:

- affected files and modules
- the observed friction
- the proposed deepening or consolidation
- the expected testing, locality, or leverage gain
- a side-by-side before and after diagram
- a strength rating: `Strong`, `Worth exploring`, or `Speculative`
- an explicit note when it conflicts with an existing architecture decision

End with one top recommendation and the reason it outranks the others. Share the report path, then ask the user which candidate to explore.

## Explore a chosen candidate

Once the user chooses, load and follow the [grilling workflow](../grilling/SKILL.md). Resolve constraints, dependencies, responsibilities, seams, and tests before designing the replacement. Do not implement until the user confirms the resulting plan.
