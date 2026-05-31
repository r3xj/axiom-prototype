# AXIOM Prototype Coding Instructions

This is a solo-dev Godot 4.x prototype for **AXIOM**, a fantasy grand strategy / discovery / logistics game.

## Current Phase

We completed the first Phase 1A prototype pass and are now doing **Phase 1B: Strategic Map Foundation Refactor**.

The purpose of Phase 1B is to replace the early node/route-based strategic map scaffolding with a more durable foundation:

* continuous world-position entities
* hidden movement-cost grid
* weighted A* pathfinding
* smooth realtime movement
* POIs/features placed in world space
* tactical-map context data derived from strategic position

This refactor should happen before adding more major gameplay systems, because future armies, caravans, AI, supply, encounters, POIs, region danger, tactical transitions, and map features will depend on the strategic map foundation.

## Phase 1B Target

Implement the minimum viable version of the new strategic map architecture.

Core goals:

* Create or formalize a strategic world coordinate system.
* Add a hidden square movement grid/cost layer.
* Support terrain types with movement costs.
* Support blocked/impassable cells.
* Support road/preferred-path cells with lower movement cost.
* Convert or adapt existing settlement/resource nodes into world-position POIs/features.
* Update map entities so they store `world_position` and move continuously.
* Implement click-to-move or command-to-move pathfinding over the movement grid.
* Convert grid paths into world-space points.
* Move entities smoothly along paths using speed × delta time.
* Add at least two movement profiles, such as caravan and army, with different terrain costs or speed behavior.
* Add debug visualization for terrain cells, calculated path, current unit/entity position, and POIs.
* Preserve existing Phase 1A functionality where reasonably possible.

## Current Prototype Loop to Preserve Where Possible

The Phase 1A target loop was:

inspect map → survey prospect → confirm material → claim deposit → establish mine → supply mine → mine ore → ship ore → test/analyze → update Codex → complete first material output.

During Phase 1B, this loop may need temporary adaptation, but do not delete working Phase 1A functionality unless it is directly necessary for the map refactor.

## Explicit Non-Goals

Do **not** implement these during Phase 1B unless explicitly requested:

* raiders
* combat
* tactical battles
* tactical combat maps
* AI decision-making
* procedural generation
* trade economy
* diplomacy
* gods
* specialists
* complex supply simulation
* polished UI/art
* multiplayer

If the task appears to require one of these systems, stop and ask for confirmation.

## Strategic Map Architecture Principles

Use this mental model:

* **World position** is where an entity actually exists.
* **Movement grid** is an invisible planning and terrain-cost lookup layer.
* **POIs/features** are authored or data-driven objects placed in world space.
* **Grid cells** are not where units “live”; they are used for pathfinding and map queries.
* **Movement should be continuous**, not cell-hopping.
* **Roads/preferred paths** should bias pathfinding through movement costs, not force route-only movement.
* **Blocked terrain** should be avoided by pathfinding.
* **Different entity types** should be able to evaluate movement costs differently.
* **Tactical transition data** should come from the world coordinate, containing/nearby grid cells, terrain, roads, POIs, and features.

Prefer a practical prototype implementation over a perfect final architecture.

## Code Style

* Use Godot 4.x GDScript.
* Use tabs for indentation.
* Avoid Variant inference warnings.
* Prefer explicit types when reading from Dictionaries.
* Keep changes small and high-confidence.
* Do not perform broad refactors unless they are directly required for Phase 1B.
* Do not change game design beyond practical prototype-grade assumptions needed for the current task.
* Document any prototype assumptions in comments or a short notes file.
* Prefer simple, readable systems over clever abstractions.

## Workflow

Before editing:

1. Read the required context files listed below.
2. Inspect relevant files/scenes.
3. Summarize the current state.
4. Identify what still depends on the old node/route movement model.
5. Propose a small implementation plan for the current step.

After editing:

1. Summarize changed files.
2. Explain the new/changed architecture in plain language.
3. Explain how to test in Godot.
4. Mention any risks, known issues, or follow-up cleanup.
5. Identify anything that still uses old node/route scaffolding.

## Required Context Order

Before coding, read:

1. `docs/design_north_star.md`
2. `docs/phase_1a_brief.md`

If a Phase 1B brief exists, read it after those:

3. `docs/phase_1b_map_foundation.md`

If a current status handoff exists, read it after the Phase 1B brief:

4. `docs/phase_1b_current_status.md`

The full GDD is available in `docs/`, but it is reference material, not implementation permission.

Do not implement future systems just because they are mentioned in the GDD.
