extends Node

signal state_changed

const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")

var material_codex: Dictionary = {}
var redglass_known: bool = false
var redglass_deposit_confirmed: bool = false

func _ready() -> void:
	material_codex = ScenarioData.get_material_codex_defaults()

func discover_redglass_ore() -> void:
	redglass_known = true
	material_codex["redglass_ore"] = ScenarioData.get_redglass_discovered_codex_entry()
	emit_signal("state_changed")

func get_display_name(good_key: String) -> String:
	if material_codex.has(good_key):
		return str(material_codex[good_key]["name"])
	return good_key.capitalize()
