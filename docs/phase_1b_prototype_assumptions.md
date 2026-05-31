# Phase 1B Prototype Assumptions

Phase 1B uses authored placeholder strategic-map data rather than procedural generation.

- World coordinates are 2D pixel-like prototype coordinates inside a 480 x 520 strategic map.
- The movement grid is 40 x 40 world units per cell and is used only for cost lookup and pathfinding.
- POIs are not movement nodes. They are world-position destinations and debug features.
- Roads are currently marked by authored sample points and expanded to nearby cells. They lower movement cost but do not force route-only movement.
- Caravan and army profiles intentionally use different speeds and terrain costs to prove the pathfinding shape before final balancing.
- Phase 1A shipments still complete through the existing simulation-hour logistics rules. They now also spawn a realtime caravan entity for map visualization, but shipment delivery timing remains compatibility scaffolding for now.
