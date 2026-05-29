extends Control

const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")
const HOURS_PER_DAY: int = 24

var selected_region_id: String = "hearthmere"
var game_hour: int = 8

var hearthmere: Dictionary = ScenarioData.get_hearthmere_starting_values()

var supply_production_labor_teams: int = 0
var active_projects: Array[Dictionary] = []
var event_log: Array[String] = []
var redglass_known: bool = false

var material_codex: Dictionary = ScenarioData.get_material_codex_defaults()

var codex_body: Label

var prospects: Dictionary = ScenarioData.get_prospects()

var redglass_deposit_confirmed: bool = false

var time_label: Label
var info_title: Label
var info_body: Label
var economy_body: Label
var prospects_body: Label
var prospect_buttons_box: VBoxContainer
var projects_body: Label
var event_log_body: Label
var supply_minus_button: Button
var supply_plus_button: Button

var region_buttons: Dictionary = {}

var region_order: Array[String] = ScenarioData.get_region_order()
var regions: Dictionary = ScenarioData.get_regions()


func _ready() -> void:
	_clear_existing_children()
	_build_ui()
	_add_event("Scenario started. Hearthmere surveys its known surroundings.")
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
	side_scroll.custom_minimum_size = Vector2(380, 0)
	side_scroll.size_flags_horizontal = Control.SIZE_FILL
	side_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	parent.add_child(side_scroll)

	var side_panel := VBoxContainer.new()
	side_panel.name = "SidePanel"
	side_panel.custom_minimum_size = Vector2(360, 0)
	side_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	side_panel.add_theme_constant_override("separation", 8)
	side_scroll.add_child(side_panel)

	_build_region_info_panel(side_panel)
	_build_prospects_panel(side_panel)
	_build_codex_panel(side_panel)
	_build_economy_panel(side_panel)
	_build_projects_panel(side_panel)
	_build_event_log_panel(side_panel)


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


func _build_prospects_panel(parent: Control) -> void:
	var prospects_panel := PanelContainer.new()
	prospects_panel.name = "ProspectsPanel"
	parent.add_child(prospects_panel)

	var prospects_content := VBoxContainer.new()
	prospects_content.name = "ProspectsContent"
	prospects_content.add_theme_constant_override("separation", 8)
	prospects_panel.add_child(prospects_content)

	var prospects_title := Label.new()
	prospects_title.text = "Prospects"
	prospects_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prospects_content.add_child(prospects_title)

	prospects_body = Label.new()
	prospects_body.text = ""
	prospects_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	prospects_content.add_child(prospects_body)

	prospect_buttons_box = VBoxContainer.new()
	prospect_buttons_box.name = "ProspectButtons"
	prospect_buttons_box.add_theme_constant_override("separation", 6)
	prospects_content.add_child(prospect_buttons_box)


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


func _build_projects_panel(parent: Control) -> void:
	var projects_panel := PanelContainer.new()
	projects_panel.name = "ProjectsPanel"
	parent.add_child(projects_panel)

	var projects_content := VBoxContainer.new()
	projects_content.name = "ProjectsContent"
	projects_content.add_theme_constant_override("separation", 8)
	projects_panel.add_child(projects_content)

	var projects_title := Label.new()
	projects_title.text = "Active Projects"
	projects_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	projects_content.add_child(projects_title)

	projects_body = Label.new()
	projects_body.text = ""
	projects_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	projects_content.add_child(projects_body)


func _build_event_log_panel(parent: Control) -> void:
	var event_panel := PanelContainer.new()
	event_panel.name = "EventLogPanel"
	parent.add_child(event_panel)

	var event_content := VBoxContainer.new()
	event_content.name = "EventLogContent"
	event_content.add_theme_constant_override("separation", 8)
	event_panel.add_child(event_content)

	var event_title := Label.new()
	event_title.text = "Event Log"
	event_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	event_content.add_child(event_title)

	event_log_body = Label.new()
	event_log_body.text = ""
	event_log_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	event_content.add_child(event_log_body)

func _build_codex_panel(parent: Control) -> void:
	var codex_panel := PanelContainer.new()
	codex_panel.name = "MaterialCodexPanel"
	parent.add_child(codex_panel)

	var codex_content := VBoxContainer.new()
	codex_content.name = "MaterialCodexContent"
	codex_content.add_theme_constant_override("separation", 8)
	codex_panel.add_child(codex_content)

	var codex_title := Label.new()
	codex_title.text = "Material Codex"
	codex_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	codex_content.add_child(codex_title)

	codex_body = Label.new()
	codex_body.text = ""
	codex_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	codex_content.add_child(codex_body)

func _select_region(region_id: String) -> void:
	selected_region_id = region_id
	_refresh_all_ui()


func _refresh_all_ui() -> void:
	_refresh_time_label()
	_refresh_region_panel()
	_refresh_region_buttons()
	_refresh_prospects_panel()
	_refresh_economy_panel()
	_refresh_projects_panel()
	_refresh_event_log_panel()
	_refresh_codex_panel()


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


func _refresh_prospects_panel() -> void:
	_clear_container_children(prospect_buttons_box)

	var matching_prospect_ids: Array[String] = []
	for prospect_id in prospects.keys():
		var prospect: Dictionary = prospects[prospect_id]
		if prospect["region_id"] == selected_region_id:
			matching_prospect_ids.append(prospect_id)

	if matching_prospect_ids.is_empty():
		prospects_body.text = "No known prospect sites in this selected region."
		return

	var text := ""
	for prospect_id in matching_prospect_ids:
		var prospect: Dictionary = prospects[prospect_id]
		text += "%s\n" % prospect["name"]
		text += "Status: %s\n" % _format_prospect_status(String(prospect["status"]))
		text += "%s\n" % prospect["visible_clue"]

		if prospect["status"] == "surveyed":
			text += "Result: %s\n" % prospect["result_text"]

		text += "\n"

		if prospect["status"] == "unsurveyed":
			var button := Button.new()
			button.text = "Survey %s (%s, 1 labor)" % [
				prospect["name"],
				_format_hours(int(prospect["survey_hours"])),
			]
			button.disabled = _get_unassigned_labor_teams() <= 0
			button.pressed.connect(_start_survey_project.bind(prospect_id))
			prospect_buttons_box.add_child(button)

	prospects_body.text = text.strip_edges()


func _refresh_economy_panel() -> void:
	var total_labor_teams := _get_total_labor_teams()
	var project_labor_teams := _get_project_labor_teams()
	var unassigned_labor_teams := _get_unassigned_labor_teams()
	var daily_supply_output := supply_production_labor_teams * float(hearthmere["supply_production_per_team_per_day"])

	economy_body.text = (
		"Population: %d\n"
		+ "Available Workforce: %d\n"
		+ "Labor Team Size: %d workers\n"
		+ "Total Labor Teams: %d\n"
		+ "Supply Production Labor: %d\n"
		+ "Project Labor: %d\n"
		+ "Unassigned Labor Teams: %d\n"
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
		supply_production_labor_teams,
		project_labor_teams,
		unassigned_labor_teams,
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


func _refresh_projects_panel() -> void:
	if active_projects.is_empty():
		projects_body.text = "No active projects."
		return

	var text := ""
	for project in active_projects:
		text += "%s\n" % project["title"]
		text += "Remaining: %s\n" % _format_hours(int(project["remaining_hours"]))
		text += "Labor: %d team\n\n" % int(project["labor_teams"])

	projects_body.text = text.strip_edges()


func _refresh_event_log_panel() -> void:
	if event_log.is_empty():
		event_log_body.text = "No events yet."
		return

	var text := ""
	var max_events: int = mini(event_log.size(), 8)
	for i in range(max_events):
		text += "- %s\n" % event_log[i]

	event_log_body.text = text.strip_edges()

func _refresh_codex_panel() -> void:
	if not redglass_known:
		codex_body.text = "No material entries discovered yet."
		return

	var redglass: Dictionary = material_codex["redglass_ore"]

	var observed_text: String = _format_string_list(redglass["observed_traits"])
	var tested_text: String = _format_string_list(redglass["tested_properties"])
	var use_text: String = _format_string_list(redglass["known_uses"])
	var field_note_text: String = _format_string_list(redglass["field_notes"])
	var unresolved_text: String = _format_string_list(redglass["unresolved_questions"])

	codex_body.text = (
		"%s\n"
		+ "Status: %s\n"
		+ "Known Source: %s\n\n"
		+ "Observed Traits:\n%s\n\n"
		+ "Tested Properties:\n%s\n\n"
		+ "Known Uses:\n%s\n\n"
		+ "Field Notes:\n%s\n\n"
		+ "Unresolved Questions:\n%s"
	) % [
		str(redglass["name"]),
		str(redglass["status"]),
		str(redglass["known_source"]),
		observed_text,
		tested_text,
		use_text,
		field_note_text,
		unresolved_text,
	]

func _advance_hours(hours: int) -> void:
	for i in range(hours):
		game_hour += 1
		_run_hourly_simulation_tick()

	_refresh_all_ui()


func _run_hourly_simulation_tick() -> void:
	_produce_supplies_for_one_hour()
	_advance_projects_for_one_hour()


func _produce_supplies_for_one_hour() -> void:
	if supply_production_labor_teams <= 0:
		return

	var daily_output := supply_production_labor_teams * float(hearthmere["supply_production_per_team_per_day"])
	var hourly_output := daily_output / float(HOURS_PER_DAY)
	var new_supply_total := float(hearthmere["supplies"]) + hourly_output

	hearthmere["supplies"] = min(new_supply_total, float(hearthmere["supply_cap"]))


func _advance_projects_for_one_hour() -> void:
	for i in range(active_projects.size() - 1, -1, -1):
		var project: Dictionary = active_projects[i]
		project["remaining_hours"] = int(project["remaining_hours"]) - 1
		active_projects[i] = project

		if int(project["remaining_hours"]) <= 0:
			active_projects.remove_at(i)
			_complete_project(project)


func _start_survey_project(prospect_id: String) -> void:
	if not prospects.has(prospect_id):
		return

	if _get_unassigned_labor_teams() <= 0:
		_add_event("No unassigned labor team is available for survey work.")
		_refresh_all_ui()
		return

	var prospect: Dictionary = prospects[prospect_id]
	if prospect["status"] != "unsurveyed":
		return

	prospect["status"] = "surveying"
	prospects[prospect_id] = prospect

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

	_add_event("Survey started: %s." % prospect["name"])
	_refresh_all_ui()


func _complete_project(project: Dictionary) -> void:
	var project_type: String = str(project["type"])

	if project_type == "survey":
		_complete_survey_project(str(project["target_id"]))
	else:
		_add_event("Project completed: %s." % str(project["title"]))


func _complete_survey_project(prospect_id: String) -> void:
	if not prospects.has(prospect_id):
		return

	var prospect: Dictionary = prospects[prospect_id]
	prospect["status"] = "surveyed"
	prospects[prospect_id] = prospect

	if prospect["outcome"] == "redglass_deposit":
		redglass_deposit_confirmed = true
		regions["redglass_foothills"]["status"] = "Known / Redglass Deposit Confirmed"
		_discover_redglass_ore()
		_add_event("Deposit confirmed: %s." % str(prospect["name"]))
		_add_event("Material Codex updated: Redglass Ore.")
	else:
		_add_event("Survey complete: %s." % prospect["name"])

	_add_event(prospect["result_text"])


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


func _get_project_labor_teams() -> int:
	var total := 0
	for project in active_projects:
		total += int(project["labor_teams"])
	return total


func _get_unassigned_labor_teams() -> int:
	var assigned := supply_production_labor_teams + _get_project_labor_teams()
	return max(0, _get_total_labor_teams() - assigned)


func _get_day_number() -> int:
	return int(floor(float(game_hour) / float(HOURS_PER_DAY))) + 1


func _get_hour_of_day() -> int:
	return game_hour % HOURS_PER_DAY


func _format_hours(hours: int) -> String:
	if hours < HOURS_PER_DAY:
		return "%dh" % hours

	var days := int(floor(float(hours) / float(HOURS_PER_DAY)))
	var remaining_hours := hours % HOURS_PER_DAY

	if remaining_hours == 0:
		return "%dd" % days

	return "%dd %dh" % [days, remaining_hours]


func _format_prospect_status(status: String) -> String:
	match status:
		"unsurveyed":
			return "Unsurveyed"
		"surveying":
			return "Surveying"
		"surveyed":
			return "Surveyed"
		_:
			return status.capitalize()


func _add_event(message: String) -> void:
	var timestamp: String = "Day %d %02d:00" % [_get_day_number(), _get_hour_of_day()]
	event_log.insert(0, "%s — %s" % [timestamp, message])


func _clear_container_children(container: Node) -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

func _format_string_list(items_variant: Variant) -> String:
	var items: Array = items_variant as Array

	if items.is_empty():
		return "- None"

	var text: String = ""
	for item in items:
		text += "- %s\n" % str(item)

	return text.strip_edges()

func _discover_redglass_ore() -> void:
	redglass_known = true
	material_codex["redglass_ore"] = ScenarioData.get_redglass_discovered_codex_entry()
