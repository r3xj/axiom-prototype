extends Node

func get_good_amount(stockpile: Dictionary, good_key: String) -> float:
	if not stockpile["goods"].has(good_key):
		return 0.0
	return float(stockpile["goods"][good_key]["amount"])

func get_good_cap(stockpile: Dictionary, good_key: String) -> float:
	if not stockpile["goods"].has(good_key):
		return 0.0
	return float(stockpile["goods"][good_key]["cap"])

func set_good_amount(stockpile: Dictionary, good_key: String, value: float) -> void:
	if not stockpile["goods"].has(good_key):
		return
	var good: Dictionary = stockpile["goods"][good_key]
	good["amount"] = clampf(value, 0.0, float(good["cap"]))
	stockpile["goods"][good_key] = good

func adjust_good_amount(stockpile: Dictionary, good_key: String, delta: float) -> void:
	if not stockpile["goods"].has(good_key):
		return
	set_good_amount(stockpile, good_key, get_good_amount(stockpile, good_key) + delta)

func add_good_to_stockpile(stockpile: Dictionary, good_key: String, cap: float) -> void:
	if stockpile["goods"].has(good_key):
		return
	stockpile["goods"][good_key] = {"amount": 0.0, "cap": cap}

func get_stockpile_for_location(location_id: String) -> Dictionary:
	if location_id == "hearthmere":
		return GameState.hearthmere["stockpile"]
	if GameState.prospects.has(location_id):
		var prospect: Dictionary = GameState.prospects[location_id]
		if prospect.has("stockpile"):
			return prospect["stockpile"]
	return {}
