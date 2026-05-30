extends Node

signal state_changed

const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")

const GOOD_DISPLAY_NAMES: Dictionary = {
	"redglass_blade": "Redglass Blade",
	"redglass_armor_piece": "Redglass Armor Piece",
}

var material_codex: Dictionary = {}
var redglass_known: bool = false
var redglass_deposit_confirmed: bool = false
var redglass_tested: bool = false

func _ready() -> void:
	material_codex = ScenarioData.get_material_codex_defaults()

func discover_redglass_ore() -> void:
	redglass_known = true
	material_codex["redglass_ore"] = ScenarioData.get_redglass_discovered_codex_entry()
	emit_signal("state_changed")

func test_redglass_ore() -> void:
	redglass_tested = true
	material_codex["redglass_ore"] = ScenarioData.get_redglass_tested_codex_entry()
	emit_signal("state_changed")

func get_display_name(good_key: String) -> String:
	if material_codex.has(good_key):
		return str(material_codex[good_key]["name"])
	if GOOD_DISPLAY_NAMES.has(good_key):
		return str(GOOD_DISPLAY_NAMES[good_key])
	return good_key.capitalize()
