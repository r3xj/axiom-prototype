extends Node

signal state_changed

const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")
const MINE_ORE_PER_HOUR: float = 0.5
const MINE_SUPPLY_COST_PER_HOUR: float = 0.5

var hearthmere: Dictionary = {}
var prospects: Dictionary = {}
var regions: Dictionary = {}
var region_order: Array[String] = []
var supply_production_labor_teams: int = 0

func _ready() -> void:
	hearthmere = ScenarioData.get_hearthmere_starting_values()
	prospects = ScenarioData.get_prospects()
	regions = ScenarioData.get_regions()
	region_order = ScenarioData.get_region_order()
	SimClock.hour_advanced.connect(_on_hour_advanced)

func _on_hour_advanced(_hour: int) -> void:
	_produce_supplies_for_one_hour()
	_produce_ore_for_one_hour()

func _produce_supplies_for_one_hour() -> void:
	if supply_production_labor_teams <= 0:
		return
	var daily_output := supply_production_labor_teams * float(hearthmere["supply_production_per_team_per_day"])
	var hourly_output := daily_output / float(SimClock.HOURS_PER_DAY)
	var current := StockpileSystem.get_good_amount(hearthmere["stockpile"], "supplies")
	StockpileSystem.set_good_amount(hearthmere["stockpile"], "supplies", current + hourly_output)

func _produce_ore_for_one_hour() -> void:
	for prospect_id in prospects.keys():
		var prospect: Dictionary = prospects[prospect_id]
		if str(prospect["status"]) != "mine_operational":
			continue

		var workers: int = int(prospect.get("mine_workers", 0))
		var stockpile: Dictionary = prospect["stockpile"]
		var produces: String = str(prospect["produces"])

		var supplies: float = StockpileSystem.get_good_amount(stockpile, "supplies")
		var ore_amount: float = StockpileSystem.get_good_amount(stockpile, produces)
		var ore_cap: float = StockpileSystem.get_good_cap(stockpile, produces)

		var new_status: String
		if workers == 0:
			new_status = "idle_no_workers"
		elif supplies < MINE_SUPPLY_COST_PER_HOUR:
			new_status = "idle_no_supplies"
		elif ore_amount >= ore_cap:
			new_status = "idle_ore_full"
		else:
			new_status = "producing"
			StockpileSystem.adjust_good_amount(stockpile, "supplies", -MINE_SUPPLY_COST_PER_HOUR)
			StockpileSystem.adjust_good_amount(stockpile, produces, MINE_ORE_PER_HOUR)

		var old_status: String = str(prospect.get("mine_production_status", ""))
		if new_status != old_status:
			prospect["mine_production_status"] = new_status
			prospects[prospect_id] = prospect
			EventBus.add_event(_format_production_status_change(str(prospect["name"]), new_status))
			emit_signal("state_changed")


func _format_production_status_change(mine_name: String, status: String) -> String:
	match status:
		"producing":
			return "Mine now producing at %s." % mine_name
		"idle_no_workers":
			return "Mine idle at %s: no workers assigned." % mine_name
		"idle_no_supplies":
			return "Mine idle at %s: supplies depleted." % mine_name
		"idle_ore_full":
			return "Mine idle at %s: ore stockpile full." % mine_name
		_:
			return "Mine status changed at %s: %s." % [mine_name, status]


func get_mine_worker_teams() -> int:
	var total: int = 0
	for prospect in prospects.values():
		if str(prospect["status"]) == "mine_operational":
			total += int(prospect.get("mine_workers", 0))
	return total


func assign_mine_worker(prospect_id: String) -> void:
	if not prospects.has(prospect_id):
		return
	var prospect: Dictionary = prospects[prospect_id]
	prospect["mine_workers"] = 1
	prospects[prospect_id] = prospect
	emit_signal("state_changed")


func remove_mine_worker(prospect_id: String) -> void:
	if not prospects.has(prospect_id):
		return
	var prospect: Dictionary = prospects[prospect_id]
	prospect["mine_workers"] = 0
	prospects[prospect_id] = prospect
	emit_signal("state_changed")


func set_supply_labor(teams: int) -> void:
	supply_production_labor_teams = teams
	emit_signal("state_changed")

func get_total_labor_teams() -> int:
	var available_workforce := int(hearthmere["available_workforce"])
	var labor_team_size := int(hearthmere["labor_team_size"])
	if labor_team_size <= 0:
		return 0
	return int(floor(float(available_workforce) / float(labor_team_size)))
