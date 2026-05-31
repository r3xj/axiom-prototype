# Phase 1B Brief: Strategic Map Foundation Refactor

## Purpose

Phase 1A proved the first prototype loop using a simple node/route-based map structure. That was useful scaffolding, but the long-term game needs a more flexible strategic map foundation before additional systems are built on top of it.

Phase 1B replaces the early node/route movement model with a continuous strategic map model:

* entities have real world positions
* movement is planned through a hidden movement-cost grid
* terrain and roads influence pathfinding
* units move smoothly in realtime
* points of interest exist at world coordinates
* future tactical encounters can derive context from the actual strategic location

This should be treated as a foundational refactor, not as a content/polish phase.

## Design Rationale

AXIOM’s strategic map needs to support realtime-but-slow movement across a regional landscape. Armies, caravans, scouts, workers, and future hostile forces should be able to move toward destinations intelligently, without being locked to explicit node-to-node routes.

The old node/route prototype is too rigid for the intended long-term design. It works for early shipment testing, but future systems will need to ask questions like:

* Where exactly is this entity on the map?
* What terrain is under this position?
* What movement cost applies here?
* Is this entity on or near a road?
* What nearby point of interest matters?
* What kind of tactical map should be generated here?
* What region, danger level, or ownership applies here?
* Can this unit type cross this terrain efficiently?
* Should a caravan prefer roads while scouts can cut through forests?

Phase 1B should establish the minimum viable architecture needed to answer those questions.

## Core Concept

The strategic map should be built around three separate concepts:

### 1. World Position

Every moving entity should have a continuous world-space position.

Example:

```gdscript
world_position: Vector2
```

This is where the entity actually exists. Units should not primarily “live in” map cells or route nodes.

### 2. Movement Grid

The movement grid is a hidden planning and terrain-cost lookup layer.

It answers questions like:

* what terrain exists here?
* is this area passable?
* how expensive is this area to cross?
* does this area contain a road or preferred path?
* what tactical context should this area imply?

Grid cells are not the entity’s true position. They are an implementation tool for pathfinding, map queries, and debug visualization.

### 3. POIs / Features

Points of interest and strategic features should exist in world space.

Examples:

* settlements
* prospects
* deposits
* mines
* camps
* ruins
* bridges
* roads
* fords
* future battle sites
* future fortifications

Existing Phase 1A nodes should be adapted into POIs or features where possible.

## Phase 1B Goals

Implement the minimum viable version of the new map foundation.

### Required Goals

* Create or formalize a strategic world coordinate system.
* Add a hidden square movement grid/cost layer.
* Support basic terrain types.
* Support terrain-specific movement costs.
* Support blocked or impassable cells.
* Support road/preferred-path cells with reduced movement cost.
* Convert or adapt existing settlement/resource nodes into world-position POIs/features.
* Update strategic entities so they store continuous `world_position`.
* Implement weighted A* pathfinding over the movement grid.
* Convert grid paths into world-space path points.
* Move entities smoothly along paths using speed × delta time.
* Add at least two movement profiles, such as caravan and army.
* Ensure different movement profiles can use different movement costs and/or speeds.
* Add debug visualization for:

  * terrain cells
  * blocked cells
  * roads/preferred paths
  * calculated path
  * entity position
  * POIs/features

### Desired Goals

These are useful but secondary:

* Keep the existing Phase 1A loop functional where reasonably possible.
* Allow click-to-move or command-to-move testing on the strategic map.
* Allow caravans or shipments to use the new movement system instead of old node routes.
* Add a simple way to inspect the terrain/cost data under the cursor.
* Add a simple way to display the entity’s current world position and current grid cell.

## Current Phase 1A Loop to Preserve Where Reasonable

The Phase 1A prototype loop was:

inspect map → survey prospect → confirm material → claim deposit → establish mine → supply mine → mine ore → ship ore → test/analyze → update Codex → complete first material output.

During Phase 1B, this loop may need temporary adaptation. However, do not delete working Phase 1A functionality unless it is directly necessary for the map refactor.

If existing functionality depends on nodes/routes, adapt it carefully into the new model rather than removing it casually.

## Non-Goals

Do not implement the following during Phase 1B unless explicitly requested:

* raiders
* combat
* tactical battles
* tactical combat maps
* AI decision-making
* procedural tactical map generation
* trade economy
* diplomacy
* gods
* specialists
* complex supply simulation
* polished UI/art
* multiplayer

Phase 1B may create placeholder hooks or context data for future encounters/tactical maps, but it should not implement those systems.

## Movement Model

Entities should move continuously in world space.

The movement grid is used to calculate a path, but entities should not hop from cell to cell. The movement system should advance entities along a world-space path by distance over time.

Conceptually:

```gdscript
distance_this_tick = movement_speed * delta_time
advance_along_path(distance_this_tick)
```

The pathfinder may return a sequence of grid cells, but that path should be converted into world-space points before movement.

Example internal flow:

1. Entity receives a destination world position.
2. Start and destination positions are converted to movement grid cells.
3. Weighted A* calculates a grid path.
4. Grid cells are converted to world-space path points.
5. Entity moves smoothly along those points over time.
6. Entity keeps its actual `world_position` updated.
7. The current grid cell can be derived from `world_position` when needed.

## Terrain and Movement Costs

Each movement grid cell should be able to store terrain/cost information.

Initial terrain types can be simple placeholders, such as:

* plains
* forest
* hills
* mountain
* water
* road

The exact set is not final. Use a practical prototype-grade implementation.

Example movement cost idea:

| Terrain  |              Caravan |        Army |   Scout |
| -------- | -------------------: | ----------: | ------: |
| Road     |                  low |         low |     low |
| Plains   |               medium |      medium |  medium |
| Forest   |                 high | medium-high |  medium |
| Hills    |                 high |        high |  medium |
| Mountain | blocked or very high |   very high |    high |
| Water    |              blocked |     blocked | blocked |

Roads should generally reduce movement cost. A road through a forest should still be understood as being in a forest-like area for future tactical context, but should be cheaper to move through than raw forest.

## Movement Profiles

Different entity types should be able to evaluate the same grid differently.

At minimum, implement two movement profiles:

### Caravan

Caravans should strongly prefer roads and avoid rough terrain.

Prototype behavior:

* roads are highly preferred
* forests/hills are expensive
* mountains/water may be blocked
* movement speed is relatively slow

### Army

Armies should prefer roads but tolerate more terrain than caravans.

Prototype behavior:

* roads are preferred
* plains are acceptable
* forests/hills are slower but usable
* mountains may be very slow or blocked depending on implementation
* movement speed is moderate

Additional profiles such as scouts, workers, mountain troops, or raiders can come later.

## Roads and Preferred Paths

Roads should not be treated as mandatory route edges. They should be treated as lower-cost movement areas.

This is important because units should be able to:

* follow roads when efficient
* leave roads when ordered to
* cut across terrain when that is cheaper or more direct
* use different routes based on movement profile

A road should bias pathfinding, not imprison movement.

## POIs and Existing Nodes

Existing Phase 1A nodes should be adapted into world-position POIs/features where possible.

A POI should have at least:

```gdscript
id
display_name
world_position
poi_type
```

Examples:

* base settlement
* prospect
* deposit
* mine
* testing/analyzing site
* future landmark

Do not assume POIs are movement nodes. A POI may be a destination, but movement to it should use the new map/pathfinding system.

## Tactical Transition Context

Phase 1B should not implement tactical battles, but it should prepare the strategic map to support them later.

Given a world position, the game should eventually be able to derive:

* containing grid cell
* terrain type
* nearby road/path
* nearby POI
* nearby feature
* whether the location is special/persistent
* generic tactical map context

For now, this can be simple and debug-oriented.

Example:

```gdscript
get_tactical_context(world_position) -> Dictionary
```

Possible returned data:

```gdscript
{
	"terrain": "forest",
	"has_road": true,
	"nearby_poi": "Old Mine",
	"context_type": "forest_road"
}
```

This is only a future-facing hook. Do not build tactical maps yet.

## Debugging and Visualization

Phase 1B should include debug visualization because pathfinding and map logic are difficult to evaluate without seeing them.

Minimum debug visualization should show:

* movement grid bounds
* terrain/cell color
* blocked cells
* roads/preferred cells
* selected entity
* current calculated path
* POIs/features

This does not need to be polished. It only needs to be readable enough to test and debug.

## Implementation Guidance

Prefer practical, readable systems over clever abstractions.

Good Phase 1B implementation priorities:

1. Get the coordinate/grid/path model working.
2. Get a single entity moving smoothly.
3. Add terrain costs.
4. Add blocked cells.
5. Add road preference.
6. Add movement profiles.
7. Adapt existing POIs/nodes.
8. Preserve or restore the Phase 1A loop where reasonable.

Avoid implementing future systems just because the new architecture makes them possible.

## Success Criteria

Phase 1B is successful when:

* A strategic entity can be commanded to move to a destination on the map.
* The entity uses weighted pathfinding instead of moving in a straight line.
* The entity moves smoothly in realtime using continuous world coordinates.
* Roads/preferred paths are favored when they are efficient.
* Blocked terrain is avoided.
* At least two movement profiles exist and can evaluate terrain differently.
* Existing Phase 1A POIs/features are represented in world space.
* The debug view makes terrain, roads, POIs, and paths understandable.
* The old node/route model is no longer the primary strategic movement foundation.

## Known Acceptable Limitations

For Phase 1B, the following limitations are acceptable:

* Placeholder terrain data is fine.
* Placeholder visuals are fine.
* The map can be small.
* Movement costs can be rough.
* Path smoothing can be basic.
* Roads can be represented as marked grid cells for now.
* Tactical context can be a simple dictionary/debug output.
* Some Phase 1A flow may temporarily use compatibility scaffolding.
* UI polish is not required.

## Follow-Up Phases

After Phase 1B, future work may include:

* better map authoring tools
* region ownership/danger overlays
* supply path logic
* caravan route templates/waypoints
* AI movement decisions
* encounter generation
* persistent special sites
* tactical map loading/generation
* road construction and degradation
* fog of war / scouting
* weather and seasonal movement effects

These are not part of Phase 1B unless explicitly requested.
