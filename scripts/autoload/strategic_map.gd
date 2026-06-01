extends Node

signal entity_changed
signal selected_entity_changed
signal entity_arrived(entity_id: String, metadata: Dictionary)

const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")

const TERRAIN_PLAINS: String = "plains"
const TERRAIN_FOREST: String = "forest"
const TERRAIN_HILLS: String = "hills"
const TERRAIN_MOUNTAIN: String = "mountain"
const TERRAIN_WATER: String = "water"

const MOVEMENT_PROFILES: Dictionary = {
	"caravan": {
		"display_name": "Caravan",
		"world_units_per_sim_hour": 26.0,
		"terrain_costs": {
			"plains": 1.2,
			"forest": 3.6,
			"hills": 3.2,
			"mountain": -1.0,
			"water": -1.0,
		},
		"road_multiplier": 0.35,
	},
	"army": {
		"display_name": "Army",
		"world_units_per_sim_hour": 34.0,
		"terrain_costs": {
			"plains": 1.1,
			"forest": 2.0,
			"hills": 2.2,
			"mountain": 5.0,
			"water": -1.0,
		},
		"road_multiplier": 0.55,
	},
	"field_crew": {
		"display_name": "Field Crew",
		"world_units_per_sim_hour": 26.0,
		"terrain_costs": {
			"plains": 1.2,
			"forest": 2.8,
			"hills": 2.8,
			"mountain": 5.0,
			"water": -1.0,
		},
		"road_multiplier": 0.45,
	},
}

var world_size: Vector2 = Vector2.ZERO
var cell_size: int = 40
var grid_size: Vector2i = Vector2i.ZERO
var cells: Array[Dictionary] = []
var pois: Dictionary = {}
var entities: Dictionary = {}
var selected_entity_id: String = "debug_caravan"
var last_hover_world_position: Vector2 = Vector2(-1.0, -1.0)
var map_validation_warnings: Array[String] = []
var map_validation_ran: bool = false


func _ready() -> void:
	_build_map()
	run_map_validation()
	_create_debug_entities()
	SimClock.simulation_time_advanced.connect(update_entities)


func update_entities(delta_sim_hours: float) -> void:
	if delta_sim_hours <= 0.0:
		return

	var changed: bool = false
	for entity_id in entities.keys():
		if _advance_entity(entity_id, delta_sim_hours):
			changed = true
	if changed:
		emit_signal("entity_changed")


func _build_map() -> void:
	var config: Dictionary = ScenarioData.get_strategic_map_config()
	world_size = config["world_size"] as Vector2
	cell_size = int(config["cell_size"])
	grid_size = Vector2i(
		int(ceil(world_size.x / float(cell_size))),
		int(ceil(world_size.y / float(cell_size)))
	)
	pois = ScenarioData.get_strategic_pois()
	_create_default_cells()
	_apply_terrain_patches()
	_apply_roads()
	_apply_blocked_cells()


func run_map_validation() -> Array[String]:
	map_validation_warnings = validate_map_data()
	map_validation_ran = true
	if map_validation_warnings.is_empty():
		EventBus.add_event("[DEBUG] Strategic map validation passed.")
	else:
		EventBus.add_event("[DEBUG] Strategic map validation found %d warning(s)." % map_validation_warnings.size())
		for warning in map_validation_warnings:
			EventBus.add_event("[DEBUG] Map data warning: %s" % warning)
	return map_validation_warnings


func get_map_validation_summary() -> String:
	if not map_validation_ran:
		return "Map Data: validation not run"
	if map_validation_warnings.is_empty():
		return "Map Data: OK"
	return "Map Data: %d warning(s)" % map_validation_warnings.size()


func validate_map_data() -> Array[String]:
	var warnings: Array[String] = []
	_validate_region_data(warnings)
	_validate_prospect_data(warnings)
	_validate_poi_data(warnings)
	_validate_shipment_locations(warnings)
	return warnings


func _validate_region_data(warnings: Array[String]) -> void:
	for region_id in GameState.region_order:
		if not GameState.regions.has(region_id):
			warnings.append("Region order references unknown region '%s'." % region_id)

	for region_key in GameState.regions.keys():
		var region_id: String = str(region_key)
		if not GameState.region_order.has(region_id):
			warnings.append("Region '%s' is not listed in region_order." % region_id)
		if not pois.has(region_id):
			warnings.append("Region '%s' has no matching strategic POI." % region_id)


func _validate_prospect_data(warnings: Array[String]) -> void:
	for prospect_key in GameState.prospects.keys():
		var prospect_id: String = str(prospect_key)
		var prospect: Dictionary = GameState.prospects[prospect_id]
		var region_id: String = str(prospect.get("region_id", ""))
		if region_id.is_empty():
			warnings.append("Prospect '%s' has no region_id." % prospect_id)
		elif not GameState.regions.has(region_id):
			warnings.append("Prospect '%s' references unknown region '%s'." % [prospect_id, region_id])

		if not pois.has(prospect_id):
			warnings.append("Prospect '%s' has no matching strategic POI for field crew targeting." % prospect_id)
			continue

		var poi: Dictionary = pois[prospect_id]
		if str(poi.get("region_id", "")) != region_id:
			warnings.append("Prospect '%s' region_id does not match its strategic POI region_id." % prospect_id)
		if not _poi_has_valid_world_position(prospect_id, poi):
			warnings.append("Prospect '%s' POI has missing or invalid world_position." % prospect_id)


func _validate_poi_data(warnings: Array[String]) -> void:
	for poi_key in pois.keys():
		var poi_id: String = str(poi_key)
		var poi: Dictionary = pois[poi_id]
		if str(poi.get("id", poi_id)) != poi_id:
			warnings.append("Strategic POI '%s' has mismatched id field." % poi_id)
		if str(poi.get("display_name", "")).is_empty():
			warnings.append("Strategic POI '%s' has no display_name." % poi_id)
		if str(poi.get("poi_type", "")).is_empty():
			warnings.append("Strategic POI '%s' has no poi_type." % poi_id)
		if not _poi_has_valid_world_position(poi_id, poi):
			warnings.append("Strategic POI '%s' has missing or invalid world_position." % poi_id)

		var region_id: String = str(poi.get("region_id", ""))
		if not region_id.is_empty() and not GameState.regions.has(region_id):
			warnings.append("Strategic POI '%s' references unknown region '%s'." % [poi_id, region_id])


func _validate_shipment_locations(warnings: Array[String]) -> void:
	var shipment_locations: Array[String] = ["hearthmere"]
	for prospect_key in GameState.prospects.keys():
		shipment_locations.append(str(prospect_key))

	for location_id in shipment_locations:
		if not _can_resolve_location_world_position(location_id):
			warnings.append("Shipment location '%s' cannot resolve to a strategic world position." % location_id)


func _poi_has_valid_world_position(_poi_id: String, poi: Dictionary) -> bool:
	if not poi.has("world_position"):
		return false
	if typeof(poi["world_position"]) != TYPE_VECTOR2:
		return false
	var world_position: Vector2 = poi["world_position"] as Vector2
	return (
		world_position.x >= 0.0
		and world_position.y >= 0.0
		and world_position.x <= world_size.x
		and world_position.y <= world_size.y
	)


func _can_resolve_location_world_position(location_id: String) -> bool:
	if pois.has(location_id):
		return _poi_has_valid_world_position(location_id, pois[location_id])
	if GameState.prospects.has(location_id):
		var prospect: Dictionary = GameState.prospects[location_id]
		var region_id: String = str(prospect.get("region_id", ""))
		return pois.has(region_id) and _poi_has_valid_world_position(region_id, pois[region_id])
	return false


func _create_default_cells() -> void:
	cells.clear()
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			cells.append({
				"terrain": TERRAIN_PLAINS,
				"blocked": false,
				"has_road": false,
			})


func _apply_terrain_patches() -> void:
	var terrain_patches: Array[Dictionary] = ScenarioData.get_strategic_terrain_patches()
	for patch in terrain_patches:
		var start_cell: Vector2i = patch["cell"] as Vector2i
		var patch_size: Vector2i = patch["size"] as Vector2i
		var terrain: String = str(patch["terrain"])
		for y in range(start_cell.y, start_cell.y + patch_size.y):
			for x in range(start_cell.x, start_cell.x + patch_size.x):
				var cell := Vector2i(x, y)
				if is_cell_in_bounds(cell):
					var data: Dictionary = get_cell_data(cell)
					data["terrain"] = terrain
					set_cell_data(cell, data)


func _apply_roads() -> void:
	var road_points: Array[Vector2] = ScenarioData.get_strategic_road_points()
	for point in road_points:
		var cell: Vector2i = world_to_cell(point)
		_mark_road_cell(cell)
		for neighbor in get_neighbors(cell):
			_mark_road_cell(neighbor)


func _mark_road_cell(cell: Vector2i) -> void:
	if not is_cell_in_bounds(cell):
		return
	var data: Dictionary = get_cell_data(cell)
	data["has_road"] = true
	set_cell_data(cell, data)


func _apply_blocked_cells() -> void:
	var blocked_cells: Array[Vector2i] = ScenarioData.get_strategic_blocked_cells()
	for cell in blocked_cells:
		if is_cell_in_bounds(cell):
			var data: Dictionary = get_cell_data(cell)
			data["blocked"] = true
			set_cell_data(cell, data)


func _create_debug_entities() -> void:
	var hearthmere_pos: Vector2 = get_poi_world_position("hearthmere")
	var ashen_pos: Vector2 = get_poi_world_position("ashen_pass")
	entities["debug_caravan"] = _make_entity("debug_caravan", "Test Caravan", "caravan", hearthmere_pos + Vector2(0, 16))
	entities["debug_army"] = _make_entity("debug_army", "Test Army", "army", ashen_pos + Vector2(0, -16))


func _make_entity(entity_id: String, display_name: String, profile_id: String, world_position: Vector2) -> Dictionary:
	var profile: Dictionary = MOVEMENT_PROFILES[profile_id]
	return {
		"id": entity_id,
		"display_name": display_name,
		"profile_id": profile_id,
		"world_position": world_position,
		"target_world_position": world_position,
		"path_origin_world_position": world_position,
		"path_points": [],
		"path_index": 0,
		"world_units_per_sim_hour": float(profile["world_units_per_sim_hour"]),
		"movement_debug_logged": false,
		"metadata": {},
	}


func create_entity(entity_id: String, display_name: String, profile_id: String, world_position: Vector2) -> void:
	if not MOVEMENT_PROFILES.has(profile_id):
		return
	entities[entity_id] = _make_entity(entity_id, display_name, profile_id, world_position)
	emit_signal("entity_changed")


func set_entity_metadata(entity_id: String, metadata: Dictionary) -> void:
	if not entities.has(entity_id):
		return
	var entity: Dictionary = entities[entity_id]
	entity["metadata"] = metadata.duplicate(true)
	entities[entity_id] = entity
	emit_signal("entity_changed")


func set_entity_display_name(entity_id: String, display_name: String) -> void:
	if not entities.has(entity_id):
		return
	var entity: Dictionary = entities[entity_id]
	entity["display_name"] = display_name
	entities[entity_id] = entity
	emit_signal("entity_changed")


func remove_entity(entity_id: String) -> void:
	if not entities.has(entity_id):
		return
	entities.erase(entity_id)
	if selected_entity_id == entity_id:
		selected_entity_id = ""
		emit_signal("selected_entity_changed")
	emit_signal("entity_changed")


func select_entity(entity_id: String) -> void:
	if not entities.has(entity_id):
		return
	selected_entity_id = entity_id
	emit_signal("selected_entity_changed")


func command_selected_entity(destination_world_position: Vector2) -> bool:
	return command_entity_to_world_position(selected_entity_id, destination_world_position)


func command_entity_to_poi(entity_id: String, poi_id: String) -> bool:
	if not pois.has(poi_id):
		return false
	return command_entity_to_world_position(entity_id, get_poi_world_position(poi_id))


func command_entity_to_world_position(entity_id: String, destination_world_position: Vector2) -> bool:
	if not entities.has(entity_id):
		EventBus.add_event("[DEBUG] Move failed: unknown entity %s." % entity_id)
		return false

	var entity: Dictionary = entities[entity_id]
	var profile_id: String = str(entity["profile_id"])
	var entity_position: Vector2 = entity["world_position"] as Vector2
	var start_cell: Vector2i = world_to_cell(entity_position)
	var goal_cell: Vector2i = world_to_cell(destination_world_position)
	var path_cells: Array[Vector2i] = find_path(start_cell, goal_cell, profile_id)
	if path_cells.is_empty():
		_log_caravan_path_debug(entity_id, profile_id, entity_position, destination_world_position, start_cell, goal_cell, path_cells, false)
		return false

	var path_points: Array[Vector2] = cells_to_world_path(path_cells, entity_position, destination_world_position)
	entity["path_origin_world_position"] = entity_position
	entity["target_world_position"] = clamp_world_position(destination_world_position)
	entity["path_points"] = path_points
	entity["path_index"] = 0
	entity["movement_debug_logged"] = false
	entities[entity_id] = entity
	_log_caravan_path_debug(entity_id, profile_id, entity_position, destination_world_position, start_cell, goal_cell, path_cells, true)
	emit_signal("entity_changed")
	return true


func find_path(start_cell: Vector2i, goal_cell: Vector2i, profile_id: String) -> Array[Vector2i]:
	if not is_cell_in_bounds(start_cell) or not is_cell_in_bounds(goal_cell):
		return []
	if get_cell_cost(start_cell, profile_id) < 0.0 or get_cell_cost(goal_cell, profile_id) < 0.0:
		return []

	var open_cells: Array[Vector2i] = [start_cell]
	var came_from: Dictionary = {}
	var g_score: Dictionary = {}
	var f_score: Dictionary = {}
	g_score[start_cell] = 0.0
	f_score[start_cell] = _heuristic(start_cell, goal_cell)

	while not open_cells.is_empty():
		var current: Vector2i = _get_lowest_score_cell(open_cells, f_score)
		if current == goal_cell:
			return _reconstruct_path(came_from, current)

		open_cells.erase(current)
		for neighbor in get_neighbors(current):
			var move_cost: float = get_cell_cost(neighbor, profile_id)
			if move_cost < 0.0:
				continue

			var step_distance: float = 1.414 if neighbor.x != current.x and neighbor.y != current.y else 1.0
			var tentative_g: float = float(g_score.get(current, INF)) + (move_cost * step_distance)
			if tentative_g < float(g_score.get(neighbor, INF)):
				came_from[neighbor] = current
				g_score[neighbor] = tentative_g
				f_score[neighbor] = tentative_g + _heuristic(neighbor, goal_cell)
				if not open_cells.has(neighbor):
					open_cells.append(neighbor)

	return []


func _get_lowest_score_cell(open_cells: Array[Vector2i], f_score: Dictionary) -> Vector2i:
	var best_cell: Vector2i = open_cells[0]
	var best_score: float = float(f_score.get(best_cell, INF))
	for cell in open_cells:
		var score: float = float(f_score.get(cell, INF))
		if score < best_score:
			best_score = score
			best_cell = cell
	return best_cell


func _reconstruct_path(came_from: Dictionary, current: Vector2i) -> Array[Vector2i]:
	var total_path: Array[Vector2i] = [current]
	while came_from.has(current):
		current = came_from[current]
		total_path.insert(0, current)
	return total_path


func _heuristic(a: Vector2i, b: Vector2i) -> float:
	return absf(float(a.x - b.x)) + absf(float(a.y - b.y))


func get_neighbors(cell: Vector2i) -> Array[Vector2i]:
	var neighbors: Array[Vector2i] = []
	for y in range(cell.y - 1, cell.y + 2):
		for x in range(cell.x - 1, cell.x + 2):
			if x == cell.x and y == cell.y:
				continue
			var neighbor := Vector2i(x, y)
			if is_cell_in_bounds(neighbor):
				neighbors.append(neighbor)
	return neighbors


func get_cell_cost(cell: Vector2i, profile_id: String) -> float:
	if not is_cell_in_bounds(cell):
		return -1.0
	if not MOVEMENT_PROFILES.has(profile_id):
		return -1.0

	var data: Dictionary = get_cell_data(cell)
	if bool(data["blocked"]):
		return -1.0

	var terrain: String = str(data["terrain"])
	var profile: Dictionary = MOVEMENT_PROFILES[profile_id]
	var terrain_costs: Dictionary = profile["terrain_costs"]
	if bool(data["has_road"]):
		var road_cost: float = float(terrain_costs.get(TERRAIN_PLAINS, 1.0)) * float(profile["road_multiplier"])
		return maxf(road_cost, 0.05)

	var cost: float = float(terrain_costs.get(terrain, -1.0))
	if cost < 0.0:
		return -1.0
	return cost


func get_cell_debug_info(world_position: Vector2) -> Dictionary:
	if (
		world_position.x < 0.0
		or world_position.y < 0.0
		or world_position.x >= world_size.x
		or world_position.y >= world_size.y
	):
		return {
			"has_cell": false,
			"world_position": world_position,
		}

	var cell: Vector2i = world_to_cell(world_position)
	var data: Dictionary = get_cell_data(cell)
	var profile_costs: Dictionary = {}
	var profile_ids: Array[String] = ["caravan", "army", "field_crew"]
	for profile_id in profile_ids:
		profile_costs[profile_id] = get_cell_cost(cell, profile_id)

	var nearby_poi_id: String = _get_nearby_poi_id(world_position, 42.0)
	var nearby_poi_name: String = ""
	if not nearby_poi_id.is_empty() and pois.has(nearby_poi_id):
		var poi: Dictionary = pois[nearby_poi_id]
		nearby_poi_name = str(poi.get("display_name", nearby_poi_id))

	return {
		"has_cell": true,
		"world_position": world_position,
		"cell": cell,
		"terrain": str(data["terrain"]),
		"has_road": bool(data["has_road"]),
		"blocked": bool(data["blocked"]),
		"nearby_poi_id": nearby_poi_id,
		"nearby_poi_name": nearby_poi_name,
		"profile_costs": profile_costs,
	}


func cells_to_world_path(path_cells: Array[Vector2i], start_world_position: Vector2, destination_world_position: Vector2) -> Array[Vector2]:
	var points: Array[Vector2] = []
	if path_cells.is_empty():
		return points

	var clamped_destination: Vector2 = clamp_world_position(destination_world_position)
	if path_cells.size() == 1:
		if start_world_position.distance_to(clamped_destination) > 0.001:
			points.append(clamped_destination)
		return points

	for i in range(1, path_cells.size()):
		var cell: Vector2i = path_cells[i]
		points.append(cell_to_world_center(cell))
	points[points.size() - 1] = clamped_destination
	return points


func get_path_world_points(entity_id: String) -> Array[Vector2]:
	if not entities.has(entity_id):
		return []
	var entity: Dictionary = entities[entity_id]
	var points: Array[Vector2] = []
	points.assign(entity["path_points"])
	return points


func estimate_path_hours(entity_id: String) -> int:
	if not entities.has(entity_id):
		return 0
	var entity: Dictionary = entities[entity_id]
	var points: Array = entity["path_points"]
	if points.is_empty():
		return 0
	var distance: float = 0.0
	var previous_position: Vector2 = entity["world_position"] as Vector2
	for point_variant in points:
		var point: Vector2 = point_variant as Vector2
		distance += previous_position.distance_to(point)
		previous_position = point
	if distance <= 0.001:
		return 0
	var world_units_per_sim_hour: float = maxf(float(entity["world_units_per_sim_hour"]), 1.0)
	return max(1, int(ceil(distance / world_units_per_sim_hour)))


func estimate_remaining_path_hours(entity_id: String) -> int:
	if not entities.has(entity_id):
		return 0
	var entity: Dictionary = entities[entity_id]
	var points: Array = entity["path_points"]
	var path_index: int = int(entity["path_index"])
	if points.is_empty() or path_index >= points.size():
		return 0

	var current_position: Vector2 = entity["world_position"] as Vector2
	var distance: float = 0.0
	var previous_position: Vector2 = current_position
	for i in range(path_index, points.size()):
		var point: Vector2 = points[i] as Vector2
		distance += previous_position.distance_to(point)
		previous_position = point

	var world_units_per_sim_hour: float = maxf(float(entity["world_units_per_sim_hour"]), 1.0)
	return max(1, int(ceil(distance / world_units_per_sim_hour)))


func get_poi_world_position(poi_id: String) -> Vector2:
	if not pois.has(poi_id):
		return Vector2.ZERO
	var poi: Dictionary = pois[poi_id]
	return poi["world_position"] as Vector2


func get_region_id_for_poi(poi_id: String) -> String:
	if not pois.has(poi_id):
		return ""
	var poi: Dictionary = pois[poi_id]
	return str(poi.get("region_id", ""))


func world_to_cell(world_position: Vector2) -> Vector2i:
	var pos: Vector2 = clamp_world_position(world_position)
	return Vector2i(
		clampi(int(floor(pos.x / float(cell_size))), 0, grid_size.x - 1),
		clampi(int(floor(pos.y / float(cell_size))), 0, grid_size.y - 1)
	)


func cell_to_world_center(cell: Vector2i) -> Vector2:
	return Vector2(
		(float(cell.x) + 0.5) * float(cell_size),
		(float(cell.y) + 0.5) * float(cell_size)
	)


func clamp_world_position(world_position: Vector2) -> Vector2:
	return Vector2(
		clampf(world_position.x, 0.0, world_size.x),
		clampf(world_position.y, 0.0, world_size.y)
	)


func is_cell_in_bounds(cell: Vector2i) -> bool:
	return cell.x >= 0 and cell.y >= 0 and cell.x < grid_size.x and cell.y < grid_size.y


func get_cell_data(cell: Vector2i) -> Dictionary:
	return cells[_cell_index(cell)].duplicate(true)


func set_cell_data(cell: Vector2i, data: Dictionary) -> void:
	cells[_cell_index(cell)] = data


func _cell_index(cell: Vector2i) -> int:
	return cell.y * grid_size.x + cell.x


func _advance_entity(entity_id: String, delta_sim_hours: float) -> bool:
	var entity: Dictionary = entities[entity_id]
	var path_points: Array = entity["path_points"]
	var path_index: int = int(entity["path_index"])
	if path_points.is_empty() or path_index >= path_points.size():
		return false

	var remaining_distance: float = float(entity["world_units_per_sim_hour"]) * delta_sim_hours
	var world_position: Vector2 = entity["world_position"] as Vector2
	var starting_position: Vector2 = world_position

	while remaining_distance > 0.0 and path_index < path_points.size():
		var target: Vector2 = path_points[path_index] as Vector2
		var to_target: Vector2 = target - world_position
		var distance_to_target: float = to_target.length()

		if distance_to_target <= 0.001:
			path_index += 1
			continue

		if remaining_distance >= distance_to_target:
			world_position = target
			remaining_distance -= distance_to_target
			path_index += 1
		else:
			world_position += to_target.normalized() * remaining_distance
			remaining_distance = 0.0

	entity["world_position"] = world_position
	entity["path_index"] = path_index
	if str(entity["profile_id"]) == "caravan" and not bool(entity.get("movement_debug_logged", false)):
		entity["movement_debug_logged"] = true
		EventBus.add_event("[DEBUG] Caravan advancing: id=%s from=%s to=%s path_index=%d/%d." % [
			entity_id,
			str(starting_position.round()),
			str(world_position.round()),
			path_index,
			path_points.size(),
		])
	var arrived: bool = path_index >= path_points.size()
	if arrived:
		entity["path_points"] = []
		entity["path_index"] = 0
	entities[entity_id] = entity
	if arrived:
		emit_signal("entity_arrived", entity_id, entity["metadata"])
	return true


func get_tactical_context(world_position: Vector2) -> Dictionary:
	var cell: Vector2i = world_to_cell(world_position)
	var data: Dictionary = get_cell_data(cell)
	var nearby_poi: String = _get_nearby_poi_id(world_position, 42.0)
	var context_type: String = str(data["terrain"])
	if bool(data["has_road"]):
		context_type += "_road"
	return {
		"world_position": clamp_world_position(world_position),
		"cell": cell,
		"terrain": str(data["terrain"]),
		"has_road": bool(data["has_road"]),
		"blocked": bool(data["blocked"]),
		"nearby_poi": nearby_poi,
		"context_type": context_type,
	}


func get_path_debug_summary(entity_id: String, destination_world_position: Vector2) -> Dictionary:
	if not entities.has(entity_id):
		return {
			"entity_id": entity_id,
			"exists": false,
			"reason": "unknown_entity",
		}

	var entity: Dictionary = entities[entity_id]
	var profile_id: String = str(entity["profile_id"])
	var start_world: Vector2 = entity["world_position"] as Vector2
	var destination_world: Vector2 = clamp_world_position(destination_world_position)
	var start_cell: Vector2i = world_to_cell(start_world)
	var goal_cell: Vector2i = world_to_cell(destination_world)
	var path_cells: Array[Vector2i] = find_path(start_cell, goal_cell, profile_id)

	return {
		"entity_id": entity_id,
		"exists": true,
		"profile_id": profile_id,
		"start_world": start_world,
		"destination_world": destination_world,
		"start_cell": start_cell,
		"destination_cell": goal_cell,
		"start_valid": is_cell_in_bounds(start_cell),
		"destination_valid": is_cell_in_bounds(goal_cell),
		"start_cost": get_cell_cost(start_cell, profile_id),
		"destination_cost": get_cell_cost(goal_cell, profile_id),
		"start_passable": get_cell_cost(start_cell, profile_id) >= 0.0,
		"destination_passable": get_cell_cost(goal_cell, profile_id) >= 0.0,
		"path_length": path_cells.size(),
		"reason": _get_path_failure_reason(start_cell, goal_cell, profile_id, path_cells),
	}


func _log_caravan_path_debug(
	entity_id: String,
	profile_id: String,
	start_world: Vector2,
	destination_world: Vector2,
	start_cell: Vector2i,
	goal_cell: Vector2i,
	path_cells: Array[Vector2i],
	assigned: bool
) -> void:
	if profile_id != "caravan":
		return

	var start_valid: bool = is_cell_in_bounds(start_cell)
	var goal_valid: bool = is_cell_in_bounds(goal_cell)
	var start_cost: float = get_cell_cost(start_cell, profile_id)
	var goal_cost: float = get_cell_cost(goal_cell, profile_id)
	var reason: String = _get_path_failure_reason(start_cell, goal_cell, profile_id, path_cells)
	EventBus.add_event(
		"[DEBUG] Caravan path: id=%s profile=%s start=%s dest=%s start_cell=%s dest_cell=%s valid=%s/%s passable=%s/%s cost=%.2f/%.2f path=%d assigned=%s reason=%s."
		% [
			entity_id,
			profile_id,
			str(start_world.round()),
			str(clamp_world_position(destination_world).round()),
			str(start_cell),
			str(goal_cell),
			str(start_valid),
			str(goal_valid),
			str(start_cost >= 0.0),
			str(goal_cost >= 0.0),
			start_cost,
			goal_cost,
			path_cells.size(),
			str(assigned),
			reason,
		]
	)


func _get_path_failure_reason(start_cell: Vector2i, goal_cell: Vector2i, profile_id: String, path_cells: Array[Vector2i]) -> String:
	if not is_cell_in_bounds(start_cell):
		return "invalid_start"
	if not is_cell_in_bounds(goal_cell):
		return "invalid_destination"
	var start_data: Dictionary = get_cell_data(start_cell)
	var goal_data: Dictionary = get_cell_data(goal_cell)
	if bool(start_data["blocked"]):
		return "blocked_start"
	if bool(goal_data["blocked"]):
		return "blocked_destination"
	if get_cell_cost(start_cell, profile_id) < 0.0:
		return "start_blocked_by_profile"
	if get_cell_cost(goal_cell, profile_id) < 0.0:
		return "destination_blocked_by_profile"
	if path_cells.is_empty():
		return "no_route"
	return "ok"


func _get_nearby_poi_id(world_position: Vector2, max_distance: float) -> String:
	var best_id: String = ""
	var best_distance: float = max_distance
	for poi_id in pois.keys():
		var poi_pos: Vector2 = get_poi_world_position(str(poi_id))
		var distance: float = world_position.distance_to(poi_pos)
		if distance <= best_distance:
			best_distance = distance
			best_id = str(poi_id)
	return best_id
