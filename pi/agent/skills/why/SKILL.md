---
name: why
description: Investigate why code or a product decision exists. Use for design rationale, tradeoffs, regressions, postmortems, and the origin of thresholds or defensive behavior. Invoke with /skill:why.
disable-model-invocation: true
---

# Why

Answer "why is this this way?" with evidence about the decision, not a plausible story inferred from the current code. Code shows mechanics. It rarely proves intent.

Use this skill for design rationale, alternatives, edge cases, product constraints, regressions, and historical questions. Use `/skill:how` when the question is only about runtime behavior.

## Establish the target

Identify the code, decision, or behavior in question. Anchor the investigation with relevant file paths, symbols, and the history that touched them. Use blame, file history, commit messages, pull requests, code comments, and tests to find the change lineage.

If the target is ambiguous, state the interpretation you are investigating. If the code cannot be identified, say what is missing.

## Gather evidence

Start with source control. Then search every relevant evidence source available in the environment, such as:

- issues and project tracking
- design documents, RFCs, ADRs, and postmortems
- team discussions
- logs, metrics, and incident records
- error tracking
- product or warehouse data

Search by symbols, feature names, commit or pull-request identifiers, authors, and dates around the change. For defensive behavior, look especially for incidents, errors, and metric changes that predate it.

For a broad investigation, divide evidence sources or questions into independent read-only searches when that is available. Keep a record of sources searched, including searches that returned nothing and sources that could not be accessed. A missing record is a gap, not proof that no rationale exists.

## Reason from the record

Keep three kinds of statement separate:

- **Direct evidence:** an explicit source says it.
- **Inference:** evidence supports it, but no source states it outright.
- **Hypothesis:** a possible explanation that the evidence cannot yet distinguish.

Cite every claim about intent with a commit, pull request, issue, document, discussion link, incident, or other concrete source. State contradictions instead of selecting the more convenient account. Match confidence to evidence: use firm language for direct evidence and qualified language for inference. Do not retrofit a reason merely because the current design looks sensible.

## Present

Adapt this outline to the question:

- **Question and code anchor.** The question, files, symbols, and relevant history.
- **What we found.** Direct evidence with citations or short quotes.
- **What we can infer.** The inference chain and its confidence.
- **Competing explanations.** Include evidence for and against each when needed.
- **What we do not know.** Unanswered questions, unavailable sources, and empty searches.
- **Sources consulted.** What each source was searched for and what it returned, including no results and justified skips.

If the investigation precedes a code change, finish with practical constraints: what the change must preserve, what may change, what to avoid, and the risks that still need validation.
