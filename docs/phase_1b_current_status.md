# Phase 1B Current Status

This is a concise handoff for the current stable AXIOM prototype state. It describes what is implemented now, not a future design target.

## Current Branch / Phase

- Branch: `phase-1b-map-foundation`
- Phase: Phase 1B Strategic Map Foundation Refactor
- Status: stable checkpoint after manual full-loop testing
- Scope remains no raiders, no combat, no AI, no tactical battles, no procedural generation, no trade, no diplomacy, no gods, no specialists, and no upkeep/population-growth systems.

## Current Working Prototype Loop

The current implemented loop is:

1. Inspect the strategic map and select a region/site.
2. Dispatch or assign a Field Crew to survey a prospect.
3. Field Crew travels to the prospect using strategic movement.
4. Field Crew performs on-site survey work.
5. Redglass deposit is confirmed.
6. Assign or dispatch a Field Crew to establish the mine.
7. Field Crew travels to the site and performs on-site mine construction.
8. Send supply shipments to the mine.
9. Assign a mine worker.
10. Mine Redglass Ore into the mine stockpile.
11. Ship Redglass Ore back to Hearthmere.
12. Analyze/test Redglass Ore at Hearthmere.
13. Update the Material Codex.
14. Forge the first Redglass output.

The old player-facing "claim deposit" step has been removed from the normal loop. Survey confirmation now leads directly to mine establishment.

## Strategic Map Foundation

- `StrategicMap` is an autoload that owns the strategic movement foundation.
- Strategic entities use continuous `world_position` values.
- The map has a hidden square movement grid used for pathfinding and debug inspection.
- Weighted A* pathing uses terrain costs, blocked/impassable cells, and road/preferred-path cells.
- Movement profiles include at least `caravan`, `army`, and `field_crew`.
- POIs and relevant prototype sites have world positions.
- Selected strategic entity state exists.
- Entity arrival signals drive travel completion for shipments, survey work, mine construction, and return-to-disband behavior.
- Movement is tied to `SimClock` simulation time, so pause and speed controls affect entities.

## Field Crew System

- Field Crews are persistent strategic entities using the `field_crew` movement profile.
- A newly spawned Field Crew reserves labor from Hearthmere.
- Field Crews can travel to sites, perform on-site work, and become idle at the site when work completes.
- Idle Field Crews can be reused for future survey or mine-establishment work.
- Explicit selected Field Crew assignment works for valid selected sites.
- Automatic dispatch/reuse/spawn behavior still works when no eligible selected crew is used.
- Idle Field Crews can be selected, moved, and sent to Return & Disband.
- Return & Disband sends the crew back to Hearthmere, or disbands immediately if already at/near Hearthmere.
- Field Crew labor is released only when disband completes.

## Project / Work Flow

- Survey and mine construction use a travel -> on-site work -> completion model.
- The existing site buttons are shortcut command chains, not a full manual assignment UI.
- Selected Field Crew assignment uses an already-reserved crew and does not reserve extra labor.
- Automatic dispatch first tries to reuse a suitable idle Field Crew, then spawns a new Hearthmere Field Crew if labor is available.
- Project status, ETA, and remaining-work text update during movement and on-site work.
- Analysis and forge projects still happen at Hearthmere using local labor and local ore.
- Analysis consumes Redglass Ore and updates the Material Codex to tested.
- Forge projects consume local material inputs and add the output to Hearthmere.

## Shipment System

- Supply and ore shipments still work.
- Shipment-created caravans are strategic entities and use strategic map pathing when a path can be assigned.
- Strategic caravan arrival is the preferred/authoritative completion path for assigned shipment entities.
- `LogisticsSystem.ROUTES` remains as shipment plan metadata and fallback timing scaffolding.
- Ashen Pass and Old Pine Road remain player-facing shipment plan choices.
- Route labels use "Plan" language to avoid implying hard node-locked movement rails.
- `travel_hours` remains as compatibility fallback if strategic caravan pathing fails.

## UI Stability / Layout

- Right-panel buttons work at 12x simulation speed.
- Interactive UI refreshes are guarded so controls are not destroyed mid-click.
- The earlier deferred refresh crash has been fixed; refresh flushing no longer floods Godot's message queue.
- The right panel no longer horizontally overflows under normal 1600x900 testing.
- The right panel is vertical-scroll only.
- Field Crew rows wrap vertically.
- Selected entity actions live near selected entity context rather than in unrelated debug tools.
- The Active Operations / Movement panel lists current travel, work, and shipment activity.
- Debug Tools / Map Inspector remains available for terrain, road, blocked-cell, and profile-cost inspection.

## Validation / Manual Testing

Known validation for this stable checkpoint:

- `git diff --check` passed during recent cleanup and stabilization passes.
- Godot verbose headless load for 15 seconds passed during recent stabilization.
- Manual full-loop test completed with no issues.
- 12x speed Field Crew selection and assignment were tested.
- Shipment plan cleanup was tested and remained working.
- Right-panel layout was checked at 1600x900 with no horizontal scrollbar.

## Remaining Known Scaffolding / Technical Debt

- `LogisticsSystem.ROUTES` still exists.
- Shipment plan choices still use Ashen Pass and Old Pine Road.
- `travel_hours` remains as fallback if strategic caravan pathing fails.
- The shipment plan model is still prototype scaffolding and should not be ripped out casually until a replacement logistics/route-planning model is designed.
- `Main.gd` UI ownership is pragmatic/prototype-grade and may eventually deserve better panel ownership.
- Some debug/status UI remains intentionally placeholder.
- No raiders, combat, AI, tactical battles, procedural generation, trade, diplomacy, gods, specialists, upkeep, or population growth are implemented yet.

## Recommended Next Steps

- Continue small QA passes after future feature work.
- Eventually design a proper shipment planning model beyond route metadata.
- Eventually improve UI architecture and panel ownership.
- Later, add region danger/security/raiders only after the Phase 1B foundation remains stable.
- Do not add combat or AI as part of documentation or stabilization work.

## Map Data Validation

`StrategicMap` now includes prototype map-data validation for regions, prospects, POIs, world positions, and shipment-relevant locations. Validation runs at startup and reports a compact status in the debug/map inspector. This is intended to catch manually coordinated data issues as Phase 1B grows.