extends Control

var selected_region_id: String = "hearthmere"

var region_order: Array[String] = [
	"silent_border",
	"blackbanner_camp",
	"ashen_pass",
	"hearthmere",
	"redglass_foothills",
	"old_pine_road",
	"westmere_farms",
]

var regions: Dictionary = {
	"hearthmere": {
		"name": "Hearthmere",
		"type": "Player Settlement",
		"status": "Known / Controlled",
		"description": "Your capital settlement. Hearthmere contains the population, labor teams, local supplies, basic forge access, academy access, and settlement stockpile.",
		"phase_1a_role": "Main command center and destination for delivered ore.",
		"known_contents": [
			"Population and workforce",
			"Labor teams",
			"Local supply stockpile",
			"Forge / workshop access",
			"Academy / testing access",
			"Settlement defense, immobile",
		],
		"available_actions": [
			"Inspect population and labor",
			"Inspect stockpiles",
			"Start supply production",
			"Start testing / analysis project",
			"Start forge output project",
		],
	},
	"redglass_foothills": {
		"name": "Redglass Foothills",
		"type": "Prospect Region",
		"status": "Known / Not Yet Surveyed",
		"description": "A foothill region with several visible prospect opportunities. One may become the main strange ore deposit after survey.",
		"phase_1a_role": "Primary discovery and future mine location.",
		"known_contents": [
			"Multiple prospect leads",
			"Rough terrain",
			"Potential future extraction site",
		],
		"available_actions": [
			"Inspect prospect leads",
			"Begin survey project",
			"Claim confirmed deposit",
			"Establish mine after claim",
		],
	},
	"ashen_pass": {
		"name": "Ashen Pass",
		"type": "Route / Dangerous Pass",
		"status": "Known / Risky",
		"description": "The fastest route between Hearthmere and the foothills. In later phases, this becomes the obvious raider pressure route.",
		"phase_1a_role": "Fast route option for shipments once logistics are implemented.",
		"known_contents": [
			"Fast road connection",
			"Risk reputation",
			"Future raider visibility space",
		],
		"available_actions": [
			"Inspect route",
			"Use as fast shipment route later",
		],
	},
	"old_pine_road": {
		"name": "Old Pine Road",
		"type": "Route / Longer Road",
		"status": "Known / Quieter",
		"description": "A slower road through older woodland and farm paths. It is less direct than Ashen Pass but safer in concept.",
		"phase_1a_role": "Slow route option for shipments once logistics are implemented.",
		"known_contents": [
			"Longer road connection",
			"Lower immediate danger",
			"Connects toward Westmere Farms",
		],
		"available_actions": [
			"Inspect route",
			"Use as slow shipment route later",
		],
	},
	"westmere_farms": {
		"name": "Westmere Farms",
		"type": "Friendly Support Region",
		"status": "Known / Friendly",
		"description": "A nearby support region. For Phase 1A it mainly exists to make the map feel less linear and to support the alternate route.",
		"phase_1a_role": "Safe support node and part of the slower shipment route.",
		"known_contents": [
			"Friendly farms",
			"Safe staging region",
			"Connection to Old Pine Road",
		],
		"available_actions": [
			"Inspect region",
		],
	},
	"blackbanner_camp": {
		"name": "Blackbanner Camp",
		"type": "Hostile Presence",
		"status": "Known / Inactive for Phase 1A",
		"description": "A local raider camp. It is visible as future pressure, but raiders are not active during Phase 1A.",
		"phase_1a_role": "Deferred until Phase 2.",
		"known_contents": [
			"Future raider source",
			"No active behavior in Phase 1A",
		],
		"available_actions": [
			"Inspect only",
		],
	},
	"silent_border": {
		"name": "The Silent Border",
		"type": "Legacy Empire Border",
		"status": "Known / Dormant",
		"description": "A quiet border region hinting at larger powers beyond the prototype. It should not affect Phase 1A gameplay.",
		"phase_1a_role": "Tone and future expansion hook.",
		"known_contents": [
			"Distant border",
			"Future Legacy Empire pressure",
		],
		"available_actions": [
			"Inspect only",
		],
	},
}

var region_buttons: Dictionary = {}

var info_title: Label
var info_body: Label


func _ready() -> void:
	_clear_existing_children()
	_build_ui()
	_select_region(selected_region_id)


func _clear_existing_children() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()


func _build_ui() -> void:
	var root_layout := HBoxContainer.new()
	root_layout.name = "RootLayout"
	root_layout.set_anchors_preset(Control.PRESET_FULL_RECT)
	root_layout.add_theme_constant_override("separation", 16)
	add_child(root_layout)

	var map_panel := PanelContainer.new()
	map_panel.name = "MapPanel"
	map_panel.custom_minimum_size = Vector2(760, 640)
	map_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	map_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	root_layout.add_child(map_panel)

	var map_content := VBoxContainer.new()
	map_content.name = "MapContent"
	map_content.add_theme_constant_override("separation", 12)
	map_panel.add_child(map_content)

	var title := Label.new()
	title.text = "AXIOM Prototype — Phase 1A"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	map_content.add_child(title)

	var subtitle := Label.new()
	subtitle.text = "Hardcoded region-node map. Click a region to inspect it."
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	map_content.add_child(subtitle)

	var map_grid := GridContainer.new()
	map_grid.name = "RegionButtonGrid"
	map_grid.columns = 3
	map_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	map_grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	map_content.add_child(map_grid)

	for region_id in region_order:
		var button := Button.new()
		button.text = regions[region_id]["name"]
		button.custom_minimum_size = Vector2(220, 84)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		button.pressed.connect(_select_region.bind(region_id))
		map_grid.add_child(button)
		region_buttons[region_id] = button

	var note := Label.new()
	note.text = "Phase 1A goal: inspect map → survey prospect → confirm material → claim deposit → mine → ship → test/forge."
	note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	map_content.add_child(note)

	var info_panel := PanelContainer.new()
	info_panel.name = "InfoPanel"
	info_panel.custom_minimum_size = Vector2(420, 640)
	info_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	root_layout.add_child(info_panel)

	var info_content := VBoxContainer.new()
	info_content.name = "InfoContent"
	info_content.add_theme_constant_override("separation", 10)
	info_panel.add_child(info_content)

	info_title = Label.new()
	info_title.text = "Select a region"
	info_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	info_content.add_child(info_title)

	info_body = Label.new()
	info_body.text = ""
	info_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info_body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	info_content.add_child(info_body)


func _select_region(region_id: String) -> void:
	selected_region_id = region_id

	for key in region_buttons.keys():
		region_buttons[key].disabled = key == region_id

	var region: Dictionary = regions[region_id]

	info_title.text = region["name"]

	var known_text := ""
	for item in region["known_contents"]:
		known_text += "- %s\n" % item

	var action_text := ""
	for action in region["available_actions"]:
		action_text += "- %s\n" % action

	info_body.text = (
		"Type: %s\n"
		+ "Status: %s\n\n"
		+ "%s\n\n"
		+ "Phase 1A Role:\n%s\n\n"
		+ "Known Contents:\n%s\n"
		+ "Available Actions:\n%s"
	) % [
		region["type"],
		region["status"],
		region["description"],
		region["phase_1a_role"],
		known_text,
		action_text,
	]
