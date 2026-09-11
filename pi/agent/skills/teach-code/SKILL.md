---
name: teach-code
description: Teach a codebase subsystem, change, or technical idea so the reader understands what it is, how it works, and why it is shaped that way. Invoke with /skill:teach-code.
disable-model-invocation: true
---

# Teach code

Teach for understanding, not for a code change. Give the reader a working model of what a thing is, how it works, and why it has its present shape.

## Investigate first

Get oriented in the relevant code and conversation. Use `/skill:how` to establish mechanics and `/skill:why` to establish rationale when each would answer part of the question. Do not redo their investigation. Combine their findings into one explanation.

Match the investigation to the question. A subsystem often needs both. A small change may need only its mechanics or its history. Keep any rationale investigation scoped unless the reason is the main question.

Preserve uncertainty from the rationale evidence. Do not turn an inference into a fact to make the explanation sound smoother.

## Choose the lesson

Infer the reader's likely goal from context, such as changing, reviewing, debugging, or learning the code. Focus on the few ideas they need for that goal. Do not repeat context they already know or quiz them to establish it.

Start with the smallest complete answer. Define the thing in plain terms, then connect it to this codebase. Explain the problem it solves and the concrete mechanism that solves it. Build outward into flow, design reasons, and edge cases only as they help the reader understand.

## Explain clearly

Teach a real path through the system. Describe what happens when an input, event, or user action moves through it. Name code only where a file, symbol, or small excerpt helps the reader verify or explore further. A list of functions is reference material, not an explanation.

Use a diagram when it explains a relationship faster than prose. For a system with several moving parts, add one part at a time in small diagrams instead of showing everything at once. Skip visuals that do not clarify an idea.

Write like a colleague explaining the code aloud. Use one name for each concept. Prefer concrete mechanisms to metaphors. Keep sentences short enough to follow. Avoid stock framing, lecture-like pacing, quizzes, and a wall of text.

When the answer is interactive, stop after a useful layer and follow the reader's lead. For a one-shot answer, lead with the main point and end with the most useful next thread to explore.
