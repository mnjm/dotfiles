---
name: simplify-code
disable-model-invocation: true
description: Reuse existing code, remove duplication, avoid unnecessary complexity, and simplify control flow without hurting readability.
---

# Simplify code changes

Before finalizing any diff:

1. **Reuse first**
   - Search adjacent files, shared utilities, and the codebase for existing logic with the same semantics.
   - Reuse suitable code instead of creating a new implementation.

2. **Remove duplication**
   - If the change repeats the same semantic operation, extract it into one clear function.
   - Do not abstract code that only happens to look similar.

3. **Keep it simple**
   - Avoid unnecessary abstractions, dependencies, configuration, and future-proofing.
   - Prefer the solution with fewer moving parts when correctness is equal.

4. **Simplify control flow**
   - Flatten unnecessary nesting and redundant branches.
   - Use clear guard clauses and idiomatic constructs where they improve readability.
   - Follow the surrounding codebase's style.

## Before finishing

- [ ] Checked for reusable existing code
- [ ] Removed semantic duplication introduced by the change
- [ ] Added no unnecessary abstraction, dependency, or configuration
- [ ] Simplified control flow without reducing readability
