extends Node

signal state_changed

const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")

var active_projects: Array[Dictionary] = []

func _ready() -> void:
	SimClock.hour_advanced.connect(_on_hour_advanced)

func _on_hour_advanced(_hour: int) -> void:
	_advance_projects_for_one_hour()

func get_project_labor_teams() -> int:
	var total := 0
	for project in active_projects:
		total += int(project["labor_teams"])
	return total

func _get_unassigned_labor_teams() -> int:
	var assigned: int = (GameState.supply_production_labor_teams
		+ get_project_labor_teams()
		+ LogisticsSystem.get_shipment_labor_teams()
		+ GameState.get_mine_worker_teams())
	return max(0, GameState.get_total_labor_teams() - assigned)

func start_survey_project(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return

	if _get_unassigned_labor_teams() <= 0:
		EventBus.add_event("No unassigned labor team is available for survey work.")
		emit_signal("state_changed")
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]
	if prospect["status"] != "unsurveyed":
		return

	prospect["status"] = "surveying"
	GameState.prospects[prospect_id] = prospect

	var project: Dictionary = {
		"id": "survey_%s" % prospect_id,
		"type": "survey",
		"target_id": prospect_id,
		"title": "Survey: %s" % prospect["name"],
		"remaining_hours": int(prospect["survey_hours"]),
		"total_hours": int(prospect["survey_hours"]),
		"labor_teams": 1,
	}
	active_projects.append(project)

	EventBus.add_event("Survey started: %s." % prospect["name"])
	emit_signal("state_changed")

func start_establish_mine_project(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return

	var prospect: Dictionary = GameState.prospects[prospect_id]

	if prospect["status"] != "surveyed":
		return

	if prospect["outcome"] != "redglass_deposit":
		return

	if _get_unassigned_labor_teams() < 2:
		EventBus.add_event("Not enough labor available to establish a mine.")
		emit_signal("state_changed")
		return

	prospect["status"] = "mine_building"
	GameState.prospects[prospect_id] = prospect

	GameState.regions["redglass_foothills"]["status"] = "Known / Mine Under Construction"

	var project: Dictionary = {
		"id": "establish_mine_%s" % prospect_id,
		"type": "establish_mine",
		"target_id": prospect_id,
		"title": "Establish Mine: %s" % prospect["name"],
		"remaining_hours": 48,
		"total_hours": 48,
		"labor_teams": 2,
		"hourly_supply_cost": 1.0,
		"supply_source": "hearthmere",
		"last_stall_log_hour": -999,
	}
	active_projects.append(project)

	EventBus.add_event("Mine construction started: %s." % prospect["name"])
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
	elif project_type == "establish_mine":
		_complete_establish_mine_project(str(project["target_id"]))
	elif project_type == "analyze_material":
		_complete_analysis_project(str(project["target_id"]))
	elif project_type == "forge_output":
		_complete_forge_project(project)
	else:
		EventBus.add_event("Project completed: %s." % str(project["title"]))

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
