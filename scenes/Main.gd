extends Control

const HOURS_PER_DAY: int = 24

var selected_region_id: String = "hearthmere"
var game_hour: int = 8

var hearthmere: Dictionary = {
	"population": 240,
	"available_workforce": 120,
	"labor_team_size": 20,
	"mobilized_manpower": 0,
	"recovering": 0,
	"recent_losses": 0,
	"supplies": 60.0,
	"supply_cap": 100.0,
	"supply_production_per_team_per_day": 12.0,
	"settlement_defense": 12,
}

var supply_production_labor_teams: int = 0

var time_label: Label
var info_title: Label
var info_body: Label
var economy_body: Label
var supply_minus_button: Button
var supply_plus_button: Button

var region_buttons: Dictionary = {}

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
			"Assign labor to supply production",
			"Start testing / analysis project later",
			"Start forge output project later",
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
			"Inspect prospect leads later",
			"Begin survey project later",
			"Claim confirmed deposit later",
			"Establish mine after claim later",
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


func _ready() -> void:
	_clear_existing_children()
	_build_ui()
	_refresh_all_ui()


func _clear_existing_children() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()


func _build_ui() -> void:
	region_buttons.clear()

	var root_layout := VBoxContainer.new()
	root_layout.name = "RootLayout"
	root_layout.set_anchors_preset(Control.PRESET_FULL_RECT)
	root_layout.add_theme_constant_override("separation", 8)
	add_child(root_layout)

	_build_top_bar(root_layout)
	_build_body(root_layout)


func _build_top_bar(parent: Control) -> void:
	var top_bar := PanelContainer.new()
	top_bar.name = "TopBar"
	top_bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	parent.add_child(top_bar)

	var top_bar_content := HBoxContainer.new()
	top_bar_content.name = "TopBarContent"
	top_bar_content.add_theme_constant_override("separation", 8)
	top_bar.add_child(top_bar_content)

	var title := Label.new()
	title.text = "AXIOM Prototype — Phase 1A"
	title.custom_minimum_size = Vector2(230, 0)
	top_bar_content.add_child(title)

	time_label = Label.new()
	time_label.custom_minimum_size = Vector2(140, 0)
	top_bar_content.add_child(time_label)

	var advance_1h_button := Button.new()
	advance_1h_button.text = "+1h"
	advance_1h_button.pressed.connect(_advance_hours.bind(1))
	top_bar_content.add_child(advance_1h_button)

	var advance_6h_button := Button.new()
	advance_6h_button.text = "+6h"
	advance_6h_button.pressed.connect(_advance_hours.bind(6))
	top_bar_content.add_child(advance_6h_button)

	var advance_24h_button := Button.new()
	advance_24h_button.text = "+24h"
	advance_24h_button.pressed.connect(_advance_hours.bind(24))
	top_bar_content.add_child(advance_24h_button)


func _build_body(parent: Control) -> void:
	var body_layout := HBoxContainer.new()
	body_layout.name = "BodyLayout"
	body_layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body_layout.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body_layout.add_theme_constant_override("separation", 8)
	parent.add_child(body_layout)

	_build_map_panel(body_layout)
	_build_side_panel(body_layout)


func _build_map_panel(parent: Control) -> void:
	var map_panel := PanelContainer.new()
	map_panel.name = "MapPanel"
	map_panel.custom_minimum_size = Vector2(420, 0)
	map_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	map_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	parent.add_child(map_panel)

	var map_content := VBoxContainer.new()
	map_content.name = "MapContent"
	map_content.add_theme_constant_override("separation", 8)
	map_panel.add_child(map_content)

	var map_title := Label.new()
	map_title.text = "Known Local Region"
	map_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	map_content.add_child(map_title)

	var subtitle := Label.new()
	subtitle.text = "Click a region to inspect it. Phase 1A is non-combat."
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	map_content.add_child(subtitle)

	var map_grid := GridContainer.new()
	map_grid.name = "RegionButtonGrid"
	map_grid.columns = 2
	map_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	map_grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	map_content.add_child(map_grid)

	for region_id in region_order:
		var button := Button.new()
		button.text = regions[region_id]["name"]
		button.custom_minimum_size = Vector2(180, 64)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		button.pressed.connect(_select_region.bind(region_id))
		map_grid.add_child(button)
		region_buttons[region_id] = button

	var note := Label.new()
	note.text = "Phase 1A goal: inspect map → survey prospect → confirm material → claim deposit → mine → ship → test/forge."
	note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	map_content.add_child(note)


func _build_side_panel(parent: Control) -> void:
	var side_scroll := ScrollContainer.new()
	side_scroll.name = "SideScroll"
	side_scroll.custom_minimum_size = Vector2(360, 0)
	side_scroll.size_flags_horizontal = Control.SIZE_FILL
	side_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	parent.add_child(side_scroll)

	var side_panel := VBoxContainer.new()
	side_panel.name = "SidePanel"
	side_panel.custom_minimum_size = Vector2(340, 0)
	side_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	side_panel.add_theme_constant_override("separation", 8)
	side_scroll.add_child(side_panel)

	_build_region_info_panel(side_panel)
	_build_economy_panel(side_panel)


func _build_region_info_panel(parent: Control) -> void:
	var info_panel := PanelContainer.new()
	info_panel.name = "InfoPanel"
	parent.add_child(info_panel)

	var info_content := VBoxContainer.new()
	info_content.name = "InfoContent"
	info_content.add_theme_constant_override("separation", 8)
	info_panel.add_child(info_content)

	info_title = Label.new()
	info_title.text = "Select a region"
	info_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	info_content.add_child(info_title)

	info_body = Label.new()
	info_body.text = ""
	info_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info_content.add_child(info_body)


func _build_economy_panel(parent: Control) -> void:
	var economy_panel := PanelContainer.new()
	economy_panel.name = "EconomyPanel"
	parent.add_child(economy_panel)

	var economy_content := VBoxContainer.new()
	economy_content.name = "EconomyContent"
	economy_content.add_theme_constant_override("separation", 8)
	economy_panel.add_child(economy_content)

	var economy_title := Label.new()
	economy_title.text = "Hearthmere Economy"
	economy_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	economy_content.add_child(economy_title)

	economy_body = Label.new()
	economy_body.text = ""
	economy_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	economy_content.add_child(economy_body)

	var labor_controls := HBoxContainer.new()
	labor_controls.name = "SupplyLaborControls"
	labor_controls.add_theme_constant_override("separation", 8)
	economy_content.add_child(labor_controls)

	supply_minus_button = Button.new()
	supply_minus_button.text = "- Supply Labor"
	supply_minus_button.pressed.connect(_change_supply_labor.bind(-1))
	labor_controls.add_child(supply_minus_button)

	supply_plus_button = Button.new()
	supply_plus_button.text = "+ Supply Labor"
	supply_plus_button.pressed.connect(_change_supply_labor.bind(1))
	labor_controls.add_child(supply_plus_button)


func _select_region(region_id: String) -> void:
	selected_region_id = region_id
	_refresh_region_panel()
	_refresh_region_buttons()


func _refresh_all_ui() -> void:
	_refresh_time_label()
	_refresh_region_panel()
	_refresh_region_buttons()
	_refresh_economy_panel()


func _refresh_time_label() -> void:
	time_label.text = "Day %d — %02d:00" % [_get_day_number(), _get_hour_of_day()]


func _refresh_region_panel() -> void:
	var region: Dictionary = regions[selected_region_id]

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


func _refresh_region_buttons() -> void:
	for key in region_buttons.keys():
		region_buttons[key].disabled = key == selected_region_id


func _refresh_economy_panel() -> void:
	var total_labor_teams := _get_total_labor_teams()
	var unassigned_labor_teams := _get_unassigned_labor_teams()
	var daily_supply_output := supply_production_labor_teams * float(hearthmere["supply_production_per_team_per_day"])

	economy_body.text = (
		"Population: %d\n"
		+ "Available Workforce: %d\n"
		+ "Labor Team Size: %d workers\n"
		+ "Total Labor Teams: %d\n"
		+ "Unassigned Labor Teams: %d\n"
		+ "Supply Production Labor: %d\n"
		+ "Supply Output: %.1f / day\n\n"
		+ "Supplies: %.1f / %.1f\n"
		+ "Mobilized Manpower: %d\n"
		+ "Recovering: %d\n"
		+ "Recent Losses: %d\n"
		+ "Settlement Defense: %d, immobile"
	) % [
		int(hearthmere["population"]),
		int(hearthmere["available_workforce"]),
		int(hearthmere["labor_team_size"]),
		total_labor_teams,
		unassigned_labor_teams,
		supply_production_labor_teams,
		daily_supply_output,
		float(hearthmere["supplies"]),
		float(hearthmere["supply_cap"]),
		int(hearthmere["mobilized_manpower"]),
		int(hearthmere["recovering"]),
		int(hearthmere["recent_losses"]),
		int(hearthmere["settlement_defense"]),
	]

	supply_minus_button.disabled = supply_production_labor_teams <= 0
	supply_plus_button.disabled = unassigned_labor_teams <= 0


func _advance_hours(hours: int) -> void:
	for i in range(hours):
		game_hour += 1
		_run_hourly_simulation_tick()

	_refresh_all_ui()


func _run_hourly_simulation_tick() -> void:
	_produce_supplies_for_one_hour()


func _produce_supplies_for_one_hour() -> void:
	if supply_production_labor_teams <= 0:
		return

	var daily_output := supply_production_labor_teams * float(hearthmere["supply_production_per_team_per_day"])
	var hourly_output := daily_output / float(HOURS_PER_DAY)
	var new_supply_total := float(hearthmere["supplies"]) + hourly_output

	hearthmere["supplies"] = min(new_supply_total, float(hearthmere["supply_cap"]))


func _change_supply_labor(delta: int) -> void:
	if delta > 0 and _get_unassigned_labor_teams() <= 0:
		return

	if delta < 0 and supply_production_labor_teams <= 0:
		return

	supply_production_labor_teams = clamp(
		supply_production_labor_teams + delta,
		0,
		_get_total_labor_teams()
	)

	_refresh_all_ui()


func _get_total_labor_teams() -> int:
	var available_workforce := int(hearthmere["available_workforce"])
	var labor_team_size := int(hearthmere["labor_team_size"])

	if labor_team_size <= 0:
		return 0

	return int(floor(float(available_workforce) / float(labor_team_size)))


func _get_unassigned_labor_teams() -> int:
	return max(0, _get_total_labor_teams() - supply_production_labor_teams)


func _get_day_number() -> int:
	return int(floor(float(game_hour) / float(HOURS_PER_DAY))) + 1


func _get_hour_of_day() -> int:
	return game_hour % HOURS_PER_DAY
