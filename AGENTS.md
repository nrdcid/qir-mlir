# Project instructions

- Do not use subagents or delegate work.
- Lead explanations with the action or result. Use short paragraphs and bold key
  terms. Keep code, diffs, and test output complete.
- Write a failing behavior test before implementation. Skip tests only for simple
  changes and explain why. Implement the smallest solution, then refactor with
  tests green. Keep changes scoped to the task.
- Use LLVM C++ style and `.clang-format`; use TableGen for dialect definitions.
- Build: `cmake --build --preset dev -j 2`.
- Test: `cmake --build build --target check-qirb`.
- Format C++ with clang-format 21 using the checked-in configuration.
- Follow `docs/roadmap.md` milestone gates. A scaffold or an upstream verifier
  passing does not establish QIR compatibility or preservation.
- Do not enable optimizations by default. Preserve the distinction between
  resource handles, mutable quantum state, and measurement slot contents.
