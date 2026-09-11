---
name: grilling
description: Stress-test a plan, decision, or idea through structured questions. Use whenever a material uncertainty, unresolved trade-off, or user decision blocks safe progress, and when the user asks to be grilled.
---

# Grilling

Resolve decision gaps with the user before acting on a plan. Never ask the user to research what your tools can find.

Treat the plan as a decision tree: decisions can depend on each other, and a decision only enters the current round once its prerequisites are settled.

## Investigate first

Pull facts from code, files, docs, history, or tools. Never ask the user for what you can find yourself. If research is still in progress, ask the independent questions now and defer only the dependent ones.

## File loop

Use one grilling file for the whole session, `/tmp/{project_name}_grill_{DDMMYY-HHMM}.md`, instead of chat. Write each round's questions there, rewriting the file as needed. While open, the file starts with `status: open` and has a `## Gist` section summarizing the user's intent. Each question includes a recommendation and an `Answer:` placeholder. After writing, stop and wait for the edited file to come back.

## Ask a round

Ask every currently answerable material decision at once, numbered, each with a recommendation. Keep questions concrete and spell out each option's consequence:

```text
Q1. <decision title>
<question and options>
Recommendation: <recommended choice and why>
Answer:
```

Never ask a question whose answer depends on another open question in the same round. Once the user responds, update the decision tree and ask the next frontier.

## Finish

Loop until no material decisions remain implicit. Then set the file's first line to `status: closed` and summarize the agreed choices with supporting evidence. Don't implement until the user confirms, unless told to proceed despite open decisions.
