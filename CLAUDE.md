# AXIOM Prototype Coding Instructions

This is a solo-dev Godot 4.x prototype for AXIOM, a fantasy grand strategy / discovery / logistics game.

## Current Phase

We are building Phase 1A only:
- no raiders
- no combat
- no AI
- no procedural generation
- no tactical battles
- no trade
- no specialists

Current target loop:
inspect map → survey prospect → confirm material → claim deposit → establish mine → supply mine → mine ore → ship ore → test/analyze → update Codex → complete first material output.

## Code Style

- Use Godot 4.x GDScript.
- Use tabs for indentation.
- Avoid Variant inference warnings. Prefer explicit types when reading from Dictionaries.
- Keep changes small and high-confidence.
- Do not perform broad refactors unless asked.
- Do not change game design without asking.
- Do not add new systems outside the current task.

## Workflow

Before editing:
1. Inspect relevant files.
2. Summarize the current state.
3. Propose a small implementation plan.

After editing:
1. Summarize changed files.
2. Explain how to test in Godot.
3. Mention any risks or follow-up cleanup.

## Required Context Order

Before coding, read:

1. `docs/design_north_star.md`
2. `docs/phase_1a_brief.md`

The full GDD is available in `docs/`, but it is reference material, not implementation permission.

Do not implement future systems just because they are mentioned in the GDD. If a task appears to require raiders, combat, AI, trade, specialists, gods, diplomacy, tactical battles, or procedural generation, stop and ask for confirmation.