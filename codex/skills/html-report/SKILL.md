---
name: html-report
description: Create a static HTML response or visual report. Use when asked to respond in HTML, generate an HTML report, or present findings with diagrams.
---

# HTML report

Create a readable, static HTML document when a visual report explains the work better than prose. Write it to the operating system's temporary directory unless the user gives a destination. State the file path in the handoff. If the user explicitly asks for inline HTML, return the document instead.

## Build the document

Produce one HTML file with a semantic structure, responsive layout, and no application behavior. Tailwind from its CDN is fine for layout. Use Mermaid from its CDN for dependency or flow diagrams. Use HTML and inline SVG when Mermaid would make the visual generic or hard to read.

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Report title</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
  </head>
  <body>...</body>
</html>
```

Keep all report content in the file. Do not add scripts beyond what the layout or Mermaid requires. Test the HTML for valid structure and confirm local paths or anchors resolve.

## Make the report legible

Lead with the findings or recommendations, not an introduction that repeats the request. Use short sections or cards. Each finding should name the subject, show evidence or affected files when relevant, state the problem, the proposed change or conclusion, and the concrete result.

Let diagrams do explanatory work. For before-and-after changes, place the diagrams side by side. For a system with several moving parts, use a sequence of small diagrams that adds one idea at a time instead of one crowded overview.

Use Mermaid for call paths, dependencies, and sequences. Use simple boxes, lines, cross-sections, or area comparisons when the point is grouping, layering, size, or contrast. Label diagrams directly and keep them compact.

Use generous whitespace, a restrained palette, and clear type. One accent color is enough. Reserve red for problems and amber for warnings. Avoid dashboard clutter, decorative charts, and interactive controls that do not help explain the report.

## Write for scanning

Use plain, concrete language. Prefer one-sentence findings and short bullets to paragraphs. Put file paths and symbols in monospace. Make every claim traceable to evidence, and distinguish evidence from inference.

For an architecture report, describe the actual modules, interfaces, implementations, dependencies, and seams. Explain the specific mechanism or tradeoff. Avoid empty verdicts such as "cleaner" or "easier to maintain."

End with a compact top recommendation or conclusion that links to the strongest supporting finding. Do not add a generic closing.
