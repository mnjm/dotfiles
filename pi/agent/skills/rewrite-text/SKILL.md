---
name: rewrite
description: Rewrite user-provided text for clarity and coherence while preserving its meaning, structure, tone, and level of certainty. Invoke with /skill:rewrite <text>.
disable-model-invocation: true
---

# Rewrite

Rewrite the text the user provides. Preserve its semantics and structure. Make the fewest changes needed for it to read clearly and coherently.

## Preserve the source

Keep the original order, headings, paragraphs, list structure, emphasis, point of view, tense, audience, and degree of certainty unless the user asks to change them. Preserve facts, examples, numbers, names, quotes, links, and technical terms. Do not add claims, explanations, conclusions, or a new voice.

Fix grammar, wording, repetition, ambiguity, and awkward transitions only when the change makes the original point clearer. Do not reorganize the text or turn prose into a list merely because another structure would be better.

## Remove AI tells carefully

Load and apply the [unslop guidance](../unslop/SKILL.md). Use it to remove filler, stock phrasing, vague language, inflated vocabulary, and distracting punctuation. Its guidance does not justify broad rewriting. When preserving the source conflicts with a stylistic preference, preserve the source.

Retain meaningful caveats and uncertainty. Do not make cautious language sound more certain, or make a direct statement more hedged.

## Reply

Return only the rewritten text. Keep its original formatting. If the user gives no text or the intended meaning cannot be determined from the text, ask one concise question instead.