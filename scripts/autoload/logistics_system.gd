extends Node

signal state_changed

const ROUTES: Dictionary = {
	"ashen_pass": {
		"name": "Ashen Pass",
		"travel_hours": 24,
	},
	"old_pine_road": {
		"name": "Old Pine Road",
		"travel_hours": 36,
	},
}
const SHIPMENT_SUPPLY_AMOUNT: float = 20.0
const SHIPMENT_ORE_AMOUNT: float = 20.0

var active_shipments: Array[Dictionary] = []

func _ready() -> void:
	SimClock.hour_advanced.connect(_on_hour_advanced)

func _on_hour_advanced(_hour: int) -> void:
	_advance_shipments_for_one_hour()

func get_shipment_labor_teams() -> int:
	var total := 0
	for shipment in active_shipments:
		total += int(shipment["labor_teams"])
	return total

func _get_unassigned_labor_teams() -> int:
	var assigned: int = (GameState.supply_production_labor_teams
		+ ProjectSystem.get_project_labor_teams()
		+ get_shipment_labor_teams()
		+ GameState.get_mine_worker_teams())
	return max(0, GameState.get_total_labor_teams() - assigned)

func get_location_name(location_id: String) -> String:
	if location_id == "hearthmere":
		return "Hearthmere"
	if GameState.prospects.has(location_id):
		return str(GameState.prospects[location_id]["name"])
	return location_id


func _build_shipment_title(cargo: Dictionary, destination_id: String) -> String:
	if cargo.size() == 1:
		var good_key: String = str(cargo.keys()[0])
		return "Ship %s → %s" % [CodexSystem.get_display_name(good_key), get_location_name(destination_id)]
	return "Ship cargo → %s" % get_location_name(destination_id)


func start_shipment(source_id: String, destination_id: String, route_id: String, cargo: Dictionary) -> void:
	if not ROUTES.has(route_id):
		return

	var source_stockpile: Dictionary = StockpileSystem.get_stockpile_for_location(source_id)
	if source_stockpile.is_empty():
		EventBus.add_event("Cannot dispatch shipment: source has no stockpile.")
		emit_signal("state_changed")
		return

	for good_key in cargo.keys():
		var required: float = float(cargo[good_key])
		if StockpileSystem.get_good_amount(source_stockpile, str(good_key)) < required:
			EventBus.add_event("Not enough %s to ship." % str(good_key))
			emit_signal("state_changed")
			return

	if _get_unassigned_labor_teams() <= 0:
		EventBus.add_event("No labor available to dispatch caravan.")
		emit_signal("state_changed")
		return

	for good_key in cargo.keys():
		StockpileSystem.adjust_good_amount(source_stockpile, str(good_key), -float(cargo[good_key]))

	var route: Dictionary = ROUTES[route_id]
	var shipment_id: String = "shipment_%d" % (active_shipments.size() + 1)
	var entity_id: String = "entity_%s" % shipment_id
	var source_position: Vector2 = _get_world_position_for_location(source_id)
	var destination_position: Vector2 = _get_world_position_for_location(destination_id)
	StrategicMap.create_entity(entity_id, "Shipment Caravan", "caravan", source_position)
	var total_hours: int = int(route["travel_hours"])
	StrategicMap.command_entity_to_world_position(entity_id, destination_position)

	var shipment: Dictionary = {
		"id": shipment_id,
		"entity_id": entity_id,
		"status": "in_transit",
		"source": source_id,
		"destination": destination_id,
		"route": route_id,
		"cargo": cargo,
		"title": _build_shipment_title(cargo, destination_id),
		"progress_hours": 0,
		"total_hours": total_hours,
		"labor_teams": 1,
		"world_position": source_position,
		"destination_world_position": destination_position,
	}

	active_shipments.append(shipment)

	EventBus.add_event("Shipment dispatched: %s via %s." % [shipment["title"], route["name"]])
	emit_signal("state_changed")

func _advance_shipments_for_one_hour() -> void:
	for i in range(active_shipments.size() - 1, -1, -1):
		var shipment: Dictionary = active_shipments[i]
		shipment["progress_hours"] = int(shipment["progress_hours"]) + 1
		shipment["world_position"] = _get_entity_world_position(str(shipment.get("entity_id", "")))
		active_shipments[i] = shipment

		if int(shipment["progress_hours"]) >= int(shipment["total_hours"]):
			active_shipments.remove_at(i)
			_complete_shipment(shipment)

func _complete_shipment(shipment: Dictionary) -> void:
	var destination_id: String = str(shipment["destination"])
	var destination_stockpile: Dictionary = StockpileSystem.get_stockpile_for_location(destination_id)
	StrategicMap.remove_entity(str(shipment.get("entity_id", "")))

	if destination_stockpile.is_empty():
		EventBus.add_event("Shipment arrived but no destination stockpile found. Cargo lost.")
		return

	var cargo: Dictionary = shipment["cargo"]
	for good_key in cargo.keys():
		var arriving_amount: float = float(cargo[good_key])
		var current: float = StockpileSystem.get_good_amount(destination_stockpile, str(good_key))
		var cap: float = StockpileSystem.get_good_cap(destination_stockpile, str(good_key))
		var space: float = cap - current
		var delivered: float = minf(arriving_amount, space)
		var wasted: float = arriving_amount - delivered

		StockpileSystem.adjust_good_amount(destination_stockpile, str(good_key), delivered)

		if wasted > 0.0:
			EventBus.add_event("Shipment overflow at %s: %.1f %s wasted (cap reached)." % [
				get_location_name(destination_id),
				wasted,
				CodexSystem.get_display_name(str(good_key)),
			])

	EventBus.add_event("Shipment arrived at %s." % get_location_name(destination_id))


func _get_world_position_for_location(location_id: String) -> Vector2:
	if StrategicMap.pois.has(location_id):
		return StrategicMap.get_poi_world_position(location_id)
	if GameState.prospects.has(location_id):
		var prospect: Dictionary = GameState.prospects[location_id]
		var region_id: String = str(prospect.get("region_id", ""))
		if StrategicMap.pois.has(region_id):
			return StrategicMap.get_poi_world_position(region_id)
	return StrategicMap.get_poi_world_position("hearthmere")


func _get_entity_world_position(entity_id: String) -> Vector2:
	if not StrategicMap.entities.has(entity_id):
		return Vector2.ZERO
	var entity: Dictionary = StrategicMap.entities[entity_id]
	return entity["world_position"] as Vector2
