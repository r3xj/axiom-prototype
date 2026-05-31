extends Node

signal state_changed

const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")
const ESTABLISH_MINE_HOURS: int = 48
const FIELD_CREW_REUSE_RADIUS: float = 240.0
const FIELD_CREW_SITE_RADIUS: float = 8.0

var active_projects: Array[Dictionary] = []

func _ready() -> void:
	SimClock.hour_advanced.connect(_on_hour_advanced)
	StrategicMap.entity_arrived.connect(_on_strategic_entity_arrived)

func _on_hour_advanced(_hour: int) -> void:
	_advance_projects_for_one_hour()

func get_project_labor_teams() -> int:
	var total := 0
	for project in active_projects:
		total += int(project["labor_teams"])
	return total


func has_available_field_crew_for_site(prospect_id: String) -> bool:
	if not StrategicMap.pois.has(prospect_id):
		return false
	var target_position: Vector2 = StrategicMap.get_poi_world_position(prospect_id)
	return not _find_available_field_crew_for_site(prospect_id, target_position).is_empty()


func _get_unassigned_labor_teams() -> int:
	var assigned: int = (GameState.supply_production_labor_teams
		+ get_project_labor_teams()
		+ GameState.get_field_crew_labor_teams()
		+ LogisticsSystem.get_shipment_labor_teams()
		+ GameState.get_mine_worker_teams())
	return max(0, GameState.get_total_labor_teams() - assigned)

func start_survey_project(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return

	if _get_unassigned_labor_teams() < GameState.FIELD_CREW_LABOR_COST:
		EventBus.add_event("No unassigned labor team is available to form a field crew.")
		emit_signal("state_changed")
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]
	if prospect["status"] != "unsurveyed":
		return

	if not StrategicMap.pois.has(prospect_id):
		EventBus.add_event("Cannot survey %s: no strategic map destination found." % str(prospect["name"]))
		emit_signal("state_changed")
		return

	var entity_id: String = "field_crew_survey_%s_%d" % [prospect_id, SimClock.game_hour]
	var source_position: Vector2 = StrategicMap.get_poi_world_position("hearthmere")
	var destination_position: Vector2 = StrategicMap.get_poi_world_position(prospect_id)
	GameState.reserve_field_crew_labor()
	StrategicMap.create_entity(entity_id, "Field Crew: %s Survey" % str(prospect["name"]), "field_crew", source_position)
	var path_assigned: bool = StrategicMap.command_entity_to_world_position(entity_id, destination_position)
	var path_debug: Dictionary = StrategicMap.get_path_debug_summary(entity_id, destination_position)
	if not path_assigned:
		StrategicMap.remove_entity(entity_id)
		GameState.release_field_crew_labor()
		EventBus.add_event("Cannot survey %s: no valid expedition path (%s)." % [
			str(prospect["name"]),
			str(path_debug.get("reason", "unknown")),
		])
		emit_signal("state_changed")
		return

	var estimated_hours: int = StrategicMap.estimate_path_hours(entity_id)
	StrategicMap.set_entity_metadata(entity_id, {
		"kind": "survey_expedition",
		"project_id": "survey_%s" % prospect_id,
		"prospect_id": prospect_id,
	})

	prospect["status"] = "surveying"
	GameState.prospects[prospect_id] = prospect

	var project: Dictionary = {
		"id": "survey_%s" % prospect_id,
		"type": "survey_expedition",
		"state": "traveling_to_site",
		"target_id": prospect_id,
		"entity_id": entity_id,
		"title": "Field Crew Survey: %s" % prospect["name"],
		"remaining_hours": estimated_hours,
		"total_hours": estimated_hours,
		"labor_teams": 0,
		"uses_strategic_entity": true,
	}
	active_projects.append(project)

	EventBus.add_event("[DEBUG] Survey expedition path assigned: %s path=%d eta=%s." % [
		str(prospect["name"]),
		int(path_debug.get("path_length", 0)),
		"%dh" % estimated_hours,
	])
	EventBus.add_event("Field crew dispatched to survey: %s." % prospect["name"])
	emit_signal("state_changed")

func start_establish_mine_project(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]

	if prospect["status"] != "surveyed":
		return

	if prospect["outcome"] != "redglass_deposit":
		return

	if not StrategicMap.pois.has(prospect_id):
		EventBus.add_event("Cannot establish mine at %s: no strategic map destination found." % str(prospect["name"]))
		emit_signal("state_changed")
		return

	var project_id: String = "establish_mine_%s" % prospect_id
	var destination_position: Vector2 = StrategicMap.get_poi_world_position(prospect_id)
	var entity_id: String = _find_available_field_crew_for_site(prospect_id, destination_position)
	var reused_field_crew: bool = not entity_id.is_empty()
	var previous_entity_metadata: Dictionary = {}
	var previous_display_name: String = ""
	if reused_field_crew:
		var previous_entity: Dictionary = StrategicMap.entities[entity_id]
		previous_entity_metadata = (previous_entity.get("metadata", {}) as Dictionary).duplicate(true)
		previous_display_name = str(previous_entity.get("display_name", "Field Crew"))
		StrategicMap.set_entity_display_name(entity_id, "Field Crew: %s Mine" % str(prospect["name"]))
		EventBus.add_event("[DEBUG] Reusing idle field crew for mine work: %s." % str(prospect["name"]))
	else:
		if _get_unassigned_labor_teams() < GameState.FIELD_CREW_LABOR_COST:
			EventBus.add_event("No unassigned labor team is available to form a field crew.")
			emit_signal("state_changed")
			return
		entity_id = "field_crew_mine_%s_%d" % [prospect_id, SimClock.game_hour]
		var source_position: Vector2 = StrategicMap.get_poi_world_position("hearthmere")
		GameState.reserve_field_crew_labor()
		StrategicMap.create_entity(entity_id, "Field Crew: %s Mine" % str(prospect["name"]), "field_crew", source_position)

	StrategicMap.set_entity_metadata(entity_id, {
		"kind": "establish_mine",
		"project_id": project_id,
		"prospect_id": prospect_id,
	})

	var entity: Dictionary = StrategicMap.entities[entity_id]
	var crew_position: Vector2 = entity["world_position"] as Vector2
	var is_at_site: bool = crew_position.distance_to(destination_position) <= FIELD_CREW_SITE_RADIUS
	var estimated_hours: int = 0
	var uses_strategic_entity: bool = false
	if not is_at_site:
		var path_assigned: bool = StrategicMap.command_entity_to_world_position(entity_id, destination_position)
		var path_debug: Dictionary = StrategicMap.get_path_debug_summary(entity_id, destination_position)
		if not path_assigned:
			if reused_field_crew:
				StrategicMap.set_entity_display_name(entity_id, previous_display_name)
				StrategicMap.set_entity_metadata(entity_id, previous_entity_metadata)
			else:
				StrategicMap.remove_entity(entity_id)
				GameState.release_field_crew_labor()
			EventBus.add_event("Cannot establish mine at %s: no valid field crew path (%s)." % [
				str(prospect["name"]),
				str(path_debug.get("reason", "unknown")),
			])
			emit_signal("state_changed")
			return

		estimated_hours = StrategicMap.estimate_path_hours(entity_id)
		uses_strategic_entity = true
		EventBus.add_event("[DEBUG] Field crew mine path assigned: %s path=%d eta=%s." % [
			str(prospect["name"]),
			int(path_debug.get("path_length", 0)),
			"%dh" % estimated_hours,
		])

	prospect["status"] = "mine_building"
	GameState.prospects[prospect_id] = prospect

	GameState.regions["redglass_foothills"]["status"] = "Known / Mine Under Construction"

	var project: Dictionary = {
		"id": project_id,
		"type": "establish_mine",
		"state": "traveling_to_site" if uses_strategic_entity else "building_on_site",
		"target_id": prospect_id,
		"entity_id": entity_id,
		"title": "Field Crew Mine: %s" % prospect["name"] if uses_strategic_entity else "Building Mine: %s" % str(prospect["name"]),
		"remaining_hours": estimated_hours if uses_strategic_entity else ESTABLISH_MINE_HOURS,
		"total_hours": estimated_hours if uses_strategic_entity else ESTABLISH_MINE_HOURS,
		"labor_teams": 0,
		"hourly_supply_cost": 1.0,
		"supply_source": "hearthmere",
		"last_stall_log_hour": -999,
		"uses_strategic_entity": uses_strategic_entity,
	}
	active_projects.append(project)

	if uses_strategic_entity:
		EventBus.add_event("Field crew dispatched to establish mine: %s." % prospect["name"])
	else:
		EventBus.add_event("[DEBUG] Field crew already at mine site; construction started: %s." % str(prospect["name"]))
		EventBus.add_event("Field crew started establishing mine: %s." % prospect["name"])
	emit_signal("state_changed")

func force_complete_top_project() -> void:
	if active_projects.is_empty():
		EventBus.add_event("[DEBUG] No active projects to complete.")
		emit_signal("state_changed")
		return
	var project: Dictionary = active_projects[0]
	active_projects.remove_at(0)
	EventBus.add_event("[DEBUG] Force-completed project: %s." % str(project["title"]))
	_complete_project(project)
	emit_signal("state_changed")

func _advance_projects_for_one_hour() -> void:
	for i in range(active_projects.size() - 1, -1, -1):
		var project: Dictionary = active_projects[i]
		if bool(project.get("uses_strategic_entity", false)):
			var entity_id: String = str(project.get("entity_id", ""))
			project["remaining_hours"] = StrategicMap.estimate_remaining_path_hours(entity_id)
			active_projects[i] = project
			continue

		var hourly_supply_cost: float = float(project.get("hourly_supply_cost", 0.0))

		if hourly_supply_cost > 0.0:
			if StockpileSystem.get_good_amount(GameState.hearthmere["stockpile"], "supplies") < hourly_supply_cost:
				var last_stall: int = int(project.get("last_stall_log_hour", -999))
				if SimClock.game_hour - last_stall >= SimClock.HOURS_PER_DAY:
					var prospect_name: String = str(GameState.prospects[str(project["target_id"])]["name"])
					EventBus.add_event("Mine construction stalled: %s. Supplies depleted." % prospect_name)
					project["last_stall_log_hour"] = SimClock.game_hour
					active_projects[i] = project
				continue

			StockpileSystem.adjust_good_amount(GameState.hearthmere["stockpile"], "supplies", -hourly_supply_cost)

		project["remaining_hours"] = int(project["remaining_hours"]) - 1
		active_projects[i] = project

		if int(project["remaining_hours"]) <= 0:
			active_projects.remove_at(i)
			_complete_project(project)

func _complete_project(project: Dictionary) -> void:
	var project_type: String = str(project["type"])

	if project_type == "survey":
		_complete_survey_project(str(project["target_id"]))
	elif project_type == "survey_expedition":
		EventBus.add_event("[DEBUG] Survey work complete: %s." % str(project["target_id"]))
		_mark_field_crew_idle(project, "survey")
		_complete_survey_project(str(project["target_id"]))
	elif project_type == "establish_mine":
		EventBus.add_event("[DEBUG] Mine establishment work complete: %s." % str(project["target_id"]))
		_mark_field_crew_idle(project, "mine_construction")
		_complete_establish_mine_project(str(project["target_id"]))
	elif project_type == "analyze_material":
		_complete_analysis_project(str(project["target_id"]))
	elif project_type == "forge_output":
		_complete_forge_project(project)
	else:
		EventBus.add_event("Project completed: %s." % str(project["title"]))


func _on_strategic_entity_arrived(entity_id: String, metadata: Dictionary) -> void:
	var arrival_kind: String = str(metadata.get("kind", ""))
	if arrival_kind != "survey_expedition" and arrival_kind != "establish_mine":
		return

	var prospect_id: String = str(metadata.get("prospect_id", ""))
	var project_id: String = str(metadata.get("project_id", ""))
	for i in range(active_projects.size() - 1, -1, -1):
		var project: Dictionary = active_projects[i]
		if str(project.get("id", "")) != project_id:
			continue
		if str(project.get("entity_id", "")) != entity_id:
			continue

		if arrival_kind == "survey_expedition":
			EventBus.add_event("[DEBUG] Survey expedition arrived: %s." % prospect_id)
			_start_on_site_survey_work(i, project, prospect_id)
		elif arrival_kind == "establish_mine":
			EventBus.add_event("[DEBUG] Field crew arrived for mine work: %s." % prospect_id)
			_start_on_site_mine_work(i, project, prospect_id)
		emit_signal("state_changed")
		return


func _start_on_site_survey_work(project_index: int, project: Dictionary, prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		StrategicMap.remove_entity(str(project.get("entity_id", "")))
		GameState.release_field_crew_labor()
		active_projects.remove_at(project_index)
		EventBus.add_event("Survey expedition arrived, but prospect no longer exists: %s." % prospect_id)
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]
	var survey_hours: int = int(prospect["survey_hours"])
	project["state"] = "surveying_on_site"
	project["uses_strategic_entity"] = false
	project["remaining_hours"] = survey_hours
	project["total_hours"] = survey_hours
	project["title"] = "Surveying On Site: %s" % str(prospect["name"])
	active_projects[project_index] = project

	EventBus.add_event("[DEBUG] Survey work started on site: %s (%s)." % [
		str(prospect["name"]),
		"%dh" % survey_hours,
	])


func _start_on_site_mine_work(project_index: int, project: Dictionary, prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		StrategicMap.remove_entity(str(project.get("entity_id", "")))
		GameState.release_field_crew_labor()
		active_projects.remove_at(project_index)
		EventBus.add_event("Field crew arrived for mine work, but prospect no longer exists: %s." % prospect_id)
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]
	project["state"] = "building_on_site"
	project["uses_strategic_entity"] = false
	project["remaining_hours"] = ESTABLISH_MINE_HOURS
	project["total_hours"] = ESTABLISH_MINE_HOURS
	project["title"] = "Building Mine: %s" % str(prospect["name"])
	active_projects[project_index] = project

	EventBus.add_event("[DEBUG] Mine establishment work started on site: %s (%s)." % [
		str(prospect["name"]),
		"%dh" % ESTABLISH_MINE_HOURS,
	])


func _mark_field_crew_idle(project: Dictionary, completed_task: String) -> void:
	var entity_id: String = str(project.get("entity_id", ""))
	if entity_id.is_empty() or not StrategicMap.entities.has(entity_id):
		return

	var prospect_id: String = str(project.get("target_id", ""))
	var site_name: String = prospect_id
	if GameState.prospects.has(prospect_id):
		var prospect: Dictionary = GameState.prospects[prospect_id]
		site_name = str(prospect["name"])

	StrategicMap.set_entity_metadata(entity_id, {
		"kind": "field_crew",
		"state": "idle",
		"last_completed_task": completed_task,
		"site_id": prospect_id,
		"prospect_id": prospect_id,
		"site_name": site_name,
	})
	EventBus.add_event("[DEBUG] Field crew now idle at %s after %s." % [
		site_name,
		completed_task.replace("_", " "),
	])


func _find_available_field_crew_for_site(prospect_id: String, target_position: Vector2) -> String:
	var best_entity_id: String = ""
	var best_distance: float = INF

	for entity_key in StrategicMap.entities.keys():
		var entity_id: String = str(entity_key)
		if not _is_available_idle_field_crew(entity_id):
			continue

		var entity: Dictionary = StrategicMap.entities[entity_id]
		var metadata: Dictionary = entity.get("metadata", {}) as Dictionary
		var entity_position: Vector2 = entity["world_position"] as Vector2
		var distance: float = entity_position.distance_to(target_position)
		var site_id: String = str(metadata.get("site_id", ""))
		var prospect_metadata_id: String = str(metadata.get("prospect_id", ""))
		var is_site_match: bool = site_id == prospect_id or prospect_metadata_id == prospect_id
		var is_near_site: bool = distance <= FIELD_CREW_REUSE_RADIUS
		if not is_site_match and not is_near_site:
			continue
		if is_site_match:
			distance = minf(distance, 0.0)

		if distance < best_distance:
			best_distance = distance
			best_entity_id = entity_id

	return best_entity_id


func _is_available_idle_field_crew(entity_id: String) -> bool:
	if not StrategicMap.entities.has(entity_id):
		return false

	var entity: Dictionary = StrategicMap.entities[entity_id]
	if str(entity.get("profile_id", "")) != "field_crew":
		return false

	var metadata: Dictionary = entity.get("metadata", {}) as Dictionary
	if str(metadata.get("state", "")) != "idle":
		return false

	var path_points: Array = entity.get("path_points", []) as Array
	if not path_points.is_empty():
		return false

	return not _is_entity_assigned_to_active_project(entity_id)


func _is_entity_assigned_to_active_project(entity_id: String) -> bool:
	for project in active_projects:
		if str(project.get("entity_id", "")) == entity_id:
			return true
	return false


func start_forge_project(output_type: String, material_inputs: Dictionary) -> void:
	var forge_outputs: Dictionary = ScenarioData.get_forge_outputs()
	var forge_costs: Dictionary = ScenarioData.get_forge_material_costs()

	if not forge_outputs.has(output_type):
		EventBus.add_event("Unknown forge output: %s." % output_type)
		emit_signal("state_changed")
		return

	if not CodexSystem.redglass_tested:
		EventBus.add_event("Material analysis required before forge output.")
		emit_signal("state_changed")
		return

	var output_def: Dictionary = forge_outputs[output_type]
	var costs: Dictionary = forge_costs.get(output_type, {})

	if _get_unassigned_labor_teams() < int(output_def["labor_teams"]):
		EventBus.add_event("Not enough labor available for forge project.")
		emit_signal("state_changed")
		return

	var stockpile: Dictionary = GameState.hearthmere["stockpile"]

	for good_key in costs.keys():
		var required: float = float(costs[good_key])
		if StockpileSystem.get_good_amount(stockpile, str(good_key)) < required:
			var display: String = CodexSystem.get_display_name(str(good_key))
			EventBus.add_event("Not enough %s at Hearthmere for forge project (need %.0f)." % [display, required])
			emit_signal("state_changed")
			return

	for good_key in costs.keys():
		StockpileSystem.adjust_good_amount(stockpile, str(good_key), -float(costs[good_key]))

	StockpileSystem.add_good_to_stockpile(stockpile, str(output_def["produces_good"]), float(output_def["stockpile_cap"]))

	var project: Dictionary = {
		"id": "forge_%s_%d" % [output_type, SimClock.game_hour],
		"type": "forge_output",
		"output_type": output_type,
		"material_inputs": material_inputs.duplicate(),
		"title": "Forge: %s" % str(output_def["name"]),
		"remaining_hours": int(output_def["duration_hours"]),
		"total_hours": int(output_def["duration_hours"]),
		"labor_teams": int(output_def["labor_teams"]),
	}
	active_projects.append(project)

	EventBus.add_event("Forge project started: %s." % str(output_def["name"]))
	emit_signal("state_changed")


func _complete_forge_project(project: Dictionary) -> void:
	var output_type: String = str(project["output_type"])
	var forge_outputs: Dictionary = ScenarioData.get_forge_outputs()

	if not forge_outputs.has(output_type):
		EventBus.add_event("Forge project completed with unknown output type: %s." % output_type)
		return

	var output_def: Dictionary = forge_outputs[output_type]
	var produces_good: String = str(output_def["produces_good"])
	var produces_amount: float = float(output_def["produces_amount"])

	StockpileSystem.adjust_good_amount(GameState.hearthmere["stockpile"], produces_good, produces_amount)

	EventBus.add_event("Forge complete: %s. Added to Hearthmere stockpile." % str(output_def["name"]))


func start_analysis_project() -> void:
	if not CodexSystem.redglass_known:
		EventBus.add_event("No known material to analyze.")
		emit_signal("state_changed")
		return

	if CodexSystem.redglass_tested:
		EventBus.add_event("Redglass Ore has already been analyzed.")
		emit_signal("state_changed")
		return

	for p in active_projects:
		if str(p["type"]) == "analyze_material":
			EventBus.add_event("Analysis already in progress.")
			emit_signal("state_changed")
			return

	if _get_unassigned_labor_teams() < 1:
		EventBus.add_event("No unassigned labor team available for analysis.")
		emit_signal("state_changed")
		return

	var ore_cost: float = 5.0
	var stockpile: Dictionary = GameState.hearthmere["stockpile"]
	if StockpileSystem.get_good_amount(stockpile, "redglass_ore") < ore_cost:
		EventBus.add_event("Not enough Redglass Ore at Hearthmere for analysis (need 5).")
		emit_signal("state_changed")
		return

	StockpileSystem.adjust_good_amount(stockpile, "redglass_ore", -ore_cost)

	var project: Dictionary = {
		"id": "analyze_redglass_ore",
		"type": "analyze_material",
		"target_id": "redglass_ore",
		"title": "Analyze: Redglass Ore",
		"remaining_hours": 48,
		"total_hours": 48,
		"labor_teams": 1,
	}
	active_projects.append(project)

	EventBus.add_event("Analysis started: Redglass Ore. Samples drawn from Hearthmere stockpile.")
	emit_signal("state_changed")


func _complete_analysis_project(material_id: String) -> void:
	if material_id == "redglass_ore":
		CodexSystem.test_redglass_ore()
		EventBus.add_event("Analysis complete: Redglass Ore. Material Codex updated.")
		EventBus.add_event("Redglass Ore shows strong edge retention and unusual thermal properties. Forge trials recommended.")
	else:
		EventBus.add_event("Analysis complete: %s." % material_id)


func _complete_survey_project(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]
	prospect["status"] = "surveyed"
	GameState.prospects[prospect_id] = prospect

	if prospect["outcome"] == "redglass_deposit":
		CodexSystem.redglass_deposit_confirmed = true
		GameState.regions["redglass_foothills"]["status"] = "Known / Redglass Deposit Confirmed"
		CodexSystem.discover_redglass_ore()
		EventBus.add_event("Deposit confirmed: %s." % str(prospect["name"]))
		EventBus.add_event("Material Codex updated: Redglass Ore.")
	else:
		EventBus.add_event("Survey complete: %s." % prospect["name"])

	EventBus.add_event(prospect["result_text"])


func _complete_establish_mine_project(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]
	prospect["status"] = "mine_operational"

	var produces: String = str(prospect["produces"])
	var mine_goods: Dictionary = {
		"supplies": {"amount": 0.0, "cap": 30.0},
	}
	mine_goods[produces] = {"amount": 0.0, "cap": 50.0}
	prospect["stockpile"] = {"goods": mine_goods}
	prospect["mine_workers"] = 0
	prospect["mine_production_status"] = "idle_no_workers"

	GameState.prospects[prospect_id] = prospect

	StockpileSystem.add_good_to_stockpile(GameState.hearthmere["stockpile"], produces, 50.0)

	GameState.regions["redglass_foothills"]["status"] = "Known / Mine Operational"

	EventBus.add_event("Mine construction complete: %s. Awaiting supply chain." % str(prospect["name"]))
	EventBus.add_event("Mine stockpile initialized at %s. Awaiting first supply shipment." % str(prospect["name"]))
