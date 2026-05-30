extends Control

const DEBUG_MODE: bool = true

var selected_region_id: String = "hearthmere"
var _suppress_refresh: bool = false

var time_label: Label
var info_title: Label
var info_body: Label
var economy_body: Label
var prospects_body: Label
var prospect_buttons_box: VBoxContainer
var projects_body: Label
var shipments_body: Label
var event_log_body: Label
var supply_minus_button: Button
var supply_plus_button: Button
var codex_body: Label

var region_buttons: Dictionary = {}


func _ready() -> void:
	_clear_existing_children()
	_build_ui()

	GameState.state_changed.connect(_on_state_changed)
	ProjectSystem.state_changed.connect(_on_state_changed)
	LogisticsSystem.state_changed.connect(_on_state_changed)
	CodexSystem.state_changed.connect(_on_state_changed)
	SimClock.hours_advanced.connect(_on_hours_advanced)

	EventBus.add_event("Scenario started. Hearthmere surveys its known surroundings.")
	_refresh_all_ui()


func _on_state_changed() -> void:
	if not _suppress_refresh:
		_refresh_all_ui()


func _on_hours_advanced() -> void:
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

	for region_id in GameState.region_order:
		var button := Button.new()
		button.text = GameState.regions[region_id]["name"]
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
	_build_shipments_panel(side_panel)
	_build_event_log_panel(side_panel)

	if DEBUG_MODE:
		_build_debug_panel(side_panel)


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


func _build_shipments_panel(parent: Control) -> void:
	var shipments_panel := PanelContainer.new()
	shipments_panel.name = "ShipmentsPanel"
	parent.add_child(shipments_panel)

	var shipments_content := VBoxContainer.new()
	shipments_content.name = "ShipmentsContent"
	shipments_content.add_theme_constant_override("separation", 8)
	shipments_panel.add_child(shipments_content)

	var shipments_title := Label.new()
	shipments_title.text = "Active Shipments"
	shipments_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	shipments_content.add_child(shipments_title)

	shipments_body = Label.new()
	shipments_body.text = ""
	shipments_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	shipments_content.add_child(shipments_body)


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


func _advance_hours(hours: int) -> void:
	_suppress_refresh = true
	SimClock.advance_hours(hours)
	_suppress_refresh = false


func _change_supply_labor(delta: int) -> void:
	if delta > 0 and _get_unassigned_labor_teams() <= 0:
		return
	if delta < 0 and GameState.supply_production_labor_teams <= 0:
		return
	var new_val: int = clampi(
		GameState.supply_production_labor_teams + delta,
		0,
		GameState.get_total_labor_teams()
	)
	GameState.set_supply_labor(new_val)


func _get_unassigned_labor_teams() -> int:
	var assigned: int = (GameState.supply_production_labor_teams
		+ ProjectSystem.get_project_labor_teams()
		+ LogisticsSystem.get_shipment_labor_teams()
		+ GameState.get_mine_worker_teams())
	return max(0, GameState.get_total_labor_teams() - assigned)


func _refresh_all_ui() -> void:
	_refresh_time_label()
	_refresh_region_panel()
	_refresh_region_buttons()
	_refresh_prospects_panel()
	_refresh_economy_panel()
	_refresh_projects_panel()
	_refresh_shipments_panel()
	_refresh_event_log_panel()
	_refresh_codex_panel()


func _refresh_time_label() -> void:
	time_label.text = "Day %d — %02d:00" % [SimClock.get_day_number(), SimClock.get_hour_of_day()]


func _refresh_region_panel() -> void:
	var region: Dictionary = GameState.regions[selected_region_id]

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
	for prospect_id in GameState.prospects.keys():
		var prospect: Dictionary = GameState.prospects[prospect_id]
		if prospect["region_id"] == selected_region_id:
			matching_prospect_ids.append(prospect_id)

	if matching_prospect_ids.is_empty():
		prospects_body.text = "No known prospect sites in this selected region."
		return

	var text := ""
	for prospect_id in matching_prospect_ids:
		var prospect: Dictionary = GameState.prospects[prospect_id]
		var status: String = str(prospect["status"])
		text += "%s\n" % prospect["name"]
		text += "Status: %s\n" % _format_prospect_status(status)
		text += "%s\n" % prospect["visible_clue"]

		if status == "surveyed":
			text += "Result: %s\n" % prospect["result_text"]
		elif status == "mine_building":
			text += "A mine is under construction here.\n"
		elif status == "mine_operational":
			if prospect.has("mine_production_status"):
				text += "Production: %s\n" % _format_mine_production_status(str(prospect["mine_production_status"]))
			if prospect.has("stockpile"):
				var mine_stockpile: Dictionary = prospect["stockpile"]
				text += "Mine Stockpile:\n"
				for good_key in mine_stockpile["goods"].keys():
					var amount: float = StockpileSystem.get_good_amount(mine_stockpile, good_key)
					var cap: float = StockpileSystem.get_good_cap(mine_stockpile, good_key)
					text += "- %s: %.1f / %.1f\n" % [CodexSystem.get_display_name(good_key), amount, cap]
			if prospect.has("mine_workers"):
				text += "Workers: %d / 1\n" % int(prospect["mine_workers"])

		text += "\n"

		if status == "unsurveyed":
			var button := Button.new()
			button.text = "Survey %s (%s, 1 labor)" % [
				prospect["name"],
				_format_hours(int(prospect["survey_hours"])),
			]
			button.disabled = _get_unassigned_labor_teams() <= 0
			button.pressed.connect(ProjectSystem.start_survey_project.bind(prospect_id))
			prospect_buttons_box.add_child(button)
		elif status == "surveyed" and str(prospect["outcome"]) == "redglass_deposit":
			var button := Button.new()
			button.text = "Establish Mine: %s (2d, 2 labor, 1.0 supply/h)" % prospect["name"]
			button.disabled = _get_unassigned_labor_teams() < 2
			button.pressed.connect(ProjectSystem.start_establish_mine_project.bind(prospect_id))
			prospect_buttons_box.add_child(button)
		elif status == "mine_operational":
			var can_dispatch: bool = (
				StockpileSystem.get_good_amount(GameState.hearthmere["stockpile"], "supplies") >= LogisticsSystem.SHIPMENT_SUPPLY_AMOUNT
				and _get_unassigned_labor_teams() >= 1
			)

			var btn_ashen := Button.new()
			btn_ashen.text = "Ship Supplies via Ashen Pass (24h, 1 labor, 20 supplies)"
			btn_ashen.disabled = not can_dispatch
			btn_ashen.pressed.connect(LogisticsSystem.start_shipment.bind("hearthmere", prospect_id, "ashen_pass", {"supplies": LogisticsSystem.SHIPMENT_SUPPLY_AMOUNT}))
			prospect_buttons_box.add_child(btn_ashen)

			var btn_pine := Button.new()
			btn_pine.text = "Ship Supplies via Old Pine Road (36h, 1 labor, 20 supplies)"
			btn_pine.disabled = not can_dispatch
			btn_pine.pressed.connect(LogisticsSystem.start_shipment.bind("hearthmere", prospect_id, "old_pine_road", {"supplies": LogisticsSystem.SHIPMENT_SUPPLY_AMOUNT}))
			prospect_buttons_box.add_child(btn_pine)

			if prospect.has("produces") and prospect.has("stockpile"):
				var produces: String = str(prospect["produces"])
				var ore_available: float = StockpileSystem.get_good_amount(prospect["stockpile"], produces)
				var can_ship_ore: bool = (
					ore_available >= LogisticsSystem.SHIPMENT_ORE_AMOUNT
					and _get_unassigned_labor_teams() >= 1
				)
				var ore_display: String = CodexSystem.get_display_name(produces)

				var btn_ore_ashen := Button.new()
				btn_ore_ashen.text = "Ship %s via Ashen Pass (24h, 1 labor, 20 ore)" % ore_display
				btn_ore_ashen.disabled = not can_ship_ore
				var ore_cargo_a: Dictionary = {}
				ore_cargo_a[produces] = LogisticsSystem.SHIPMENT_ORE_AMOUNT
				btn_ore_ashen.pressed.connect(LogisticsSystem.start_shipment.bind(prospect_id, "hearthmere", "ashen_pass", ore_cargo_a))
				prospect_buttons_box.add_child(btn_ore_ashen)

				var btn_ore_pine := Button.new()
				btn_ore_pine.text = "Ship %s via Old Pine Road (36h, 1 labor, 20 ore)" % ore_display
				btn_ore_pine.disabled = not can_ship_ore
				var ore_cargo_p: Dictionary = {}
				ore_cargo_p[produces] = LogisticsSystem.SHIPMENT_ORE_AMOUNT
				btn_ore_pine.pressed.connect(LogisticsSystem.start_shipment.bind(prospect_id, "hearthmere", "old_pine_road", ore_cargo_p))
				prospect_buttons_box.add_child(btn_ore_pine)

			if prospect.has("mine_workers"):
				var workers: int = int(prospect["mine_workers"])

				var btn_add_worker := Button.new()
				btn_add_worker.text = "[+] Assign Worker to Mine"
				btn_add_worker.disabled = workers >= 1 or _get_unassigned_labor_teams() <= 0
				btn_add_worker.pressed.connect(_assign_mine_worker.bind(prospect_id))
				prospect_buttons_box.add_child(btn_add_worker)

				var btn_remove_worker := Button.new()
				btn_remove_worker.text = "[-] Remove Worker from Mine"
				btn_remove_worker.disabled = workers <= 0
				btn_remove_worker.pressed.connect(_remove_mine_worker.bind(prospect_id))
				prospect_buttons_box.add_child(btn_remove_worker)

	prospects_body.text = text.strip_edges()


func _refresh_economy_panel() -> void:
	var total_labor_teams: int = GameState.get_total_labor_teams()
	var project_labor_teams: int = ProjectSystem.get_project_labor_teams()
	var shipment_labor_teams: int = LogisticsSystem.get_shipment_labor_teams()
	var unassigned_labor_teams: int = _get_unassigned_labor_teams()
	var daily_supply_output: float = GameState.supply_production_labor_teams * float(GameState.hearthmere["supply_production_per_team_per_day"])

	var stockpile_text := "Hearthmere Stockpile:\n"
	for good_key in GameState.hearthmere["stockpile"]["goods"].keys():
		var amount: float = StockpileSystem.get_good_amount(GameState.hearthmere["stockpile"], good_key)
		var cap: float = StockpileSystem.get_good_cap(GameState.hearthmere["stockpile"], good_key)
		stockpile_text += "- %s: %.1f / %.1f\n" % [CodexSystem.get_display_name(good_key), amount, cap]

	economy_body.text = (
		"Population: %d\n"
		+ "Available Workforce: %d\n"
		+ "Labor Team Size: %d workers\n"
		+ "Total Labor Teams: %d\n"
		+ "Supply Production Labor: %d\n"
		+ "Project Labor: %d\n"
		+ "Shipment Labor: %d\n"
		+ "Unassigned Labor Teams: %d\n"
		+ "Supply Output: %.1f / day\n\n"
		+ "%s\n"
		+ "Mobilized Manpower: %d\n"
		+ "Recovering: %d\n"
		+ "Recent Losses: %d\n"
		+ "Settlement Defense: %d, immobile"
	) % [
		int(GameState.hearthmere["population"]),
		int(GameState.hearthmere["available_workforce"]),
		int(GameState.hearthmere["labor_team_size"]),
		total_labor_teams,
		GameState.supply_production_labor_teams,
		project_labor_teams,
		shipment_labor_teams,
		unassigned_labor_teams,
		daily_supply_output,
		stockpile_text.strip_edges(),
		int(GameState.hearthmere["mobilized_manpower"]),
		int(GameState.hearthmere["recovering"]),
		int(GameState.hearthmere["recent_losses"]),
		int(GameState.hearthmere["settlement_defense"]),
	]

	supply_minus_button.disabled = GameState.supply_production_labor_teams <= 0
	supply_plus_button.disabled = unassigned_labor_teams <= 0


func _refresh_projects_panel() -> void:
	if ProjectSystem.active_projects.is_empty():
		projects_body.text = "No active projects."
		return

	var text := ""
	for project in ProjectSystem.active_projects:
		text += "%s\n" % project["title"]
		text += "Remaining: %s\n" % _format_hours(int(project["remaining_hours"]))
		text += "Labor: %d team\n\n" % int(project["labor_teams"])

	projects_body.text = text.strip_edges()


func _refresh_shipments_panel() -> void:
	if LogisticsSystem.active_shipments.is_empty():
		shipments_body.text = "No active shipments."
		return

	var text := ""
	for shipment in LogisticsSystem.active_shipments:
		var destination_id: String = str(shipment["destination"])
		var route_id: String = str(shipment["route"])
		text += "Ship Supplies → %s\n" % str(GameState.prospects[destination_id]["name"])
		text += "Status: %s\n" % str(shipment["status"])
		text += "Route: %s\n" % str(LogisticsSystem.ROUTES[route_id]["name"])
		text += "Progress: %dh / %dh\n" % [int(shipment["progress_hours"]), int(shipment["total_hours"])]
		var cargo: Dictionary = shipment["cargo"]
		for good_key in cargo.keys():
			text += "Cargo: %s: %.1f\n" % [CodexSystem.get_display_name(good_key), float(cargo[good_key])]
		text += "Labor: %d team\n\n" % int(shipment["labor_teams"])

	shipments_body.text = text.strip_edges()


func _refresh_event_log_panel() -> void:
	var events: Array = EventBus.get_recent_events(8)
	if events.is_empty():
		event_log_body.text = "No events yet."
		return

	var text := ""
	for event_str in events:
		text += "- %s\n" % event_str

	event_log_body.text = text.strip_edges()


func _refresh_codex_panel() -> void:
	if not CodexSystem.redglass_known:
		codex_body.text = "No material entries discovered yet."
		return

	var redglass: Dictionary = CodexSystem.material_codex["redglass_ore"]

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


func _format_hours(hours: int) -> String:
	if hours < 24:
		return "%dh" % hours

	var days := int(floor(float(hours) / 24.0))
	var remaining_hours := hours % 24

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
		"mine_building":
			return "Mine under construction"
		"mine_operational":
			return "Mine operational"
		_:
			return status.capitalize()


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


func _assign_mine_worker(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return
	var prospect: Dictionary = GameState.prospects[prospect_id]
	if str(prospect["status"]) != "mine_operational":
		return
	if int(prospect.get("mine_workers", 0)) >= 1:
		return
	if _get_unassigned_labor_teams() <= 0:
		EventBus.add_event("No unassigned labor available to staff mine.")
		return
	GameState.assign_mine_worker(prospect_id)


func _remove_mine_worker(prospect_id: String) -> void:
	if not GameState.prospects.has(prospect_id):
		return
	var prospect: Dictionary = GameState.prospects[prospect_id]
	if int(prospect.get("mine_workers", 0)) <= 0:
		return
	GameState.remove_mine_worker(prospect_id)


func _format_mine_production_status(status: String) -> String:
	match status:
		"producing":
			return "Producing 0.5 ore/h"
		"idle_no_workers":
			return "Idle — no workers assigned"
		"idle_no_supplies":
			return "Idle — supplies depleted"
		"idle_ore_full":
			return "Idle — ore stockpile full"
		_:
			return status


func _build_debug_panel(parent: Control) -> void:
	var debug_panel := PanelContainer.new()
	debug_panel.name = "DebugPanel"
	parent.add_child(debug_panel)

	var debug_content := VBoxContainer.new()
	debug_content.name = "DebugContent"
	debug_content.add_theme_constant_override("separation", 8)
	debug_panel.add_child(debug_content)

	var debug_title := Label.new()
	debug_title.text = "[DEBUG] Debug Tools"
	debug_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	debug_content.add_child(debug_title)

	var supplies_label := Label.new()
	supplies_label.text = "— Supplies —"
	debug_content.add_child(supplies_label)

	var btn_set_0 := Button.new()
	btn_set_0.text = "[D] Set Supplies: 0"
	btn_set_0.pressed.connect(_debug_set_supplies.bind(0.0))
	debug_content.add_child(btn_set_0)

	var btn_set_50 := Button.new()
	btn_set_50.text = "[D] Set Supplies: 50"
	btn_set_50.pressed.connect(_debug_set_supplies.bind(50.0))
	debug_content.add_child(btn_set_50)

	var btn_set_full := Button.new()
	btn_set_full.text = "[D] Set Supplies: Full"
	btn_set_full.pressed.connect(_debug_set_supplies.bind(-1.0))
	debug_content.add_child(btn_set_full)

	var btn_add_10 := Button.new()
	btn_add_10.text = "[D] +10 Supplies"
	btn_add_10.pressed.connect(_debug_adjust_supplies.bind(10.0))
	debug_content.add_child(btn_add_10)

	var btn_sub_10 := Button.new()
	btn_sub_10.text = "[D] -10 Supplies"
	btn_sub_10.pressed.connect(_debug_adjust_supplies.bind(-10.0))
	debug_content.add_child(btn_sub_10)

	var debug_time_label := Label.new()
	debug_time_label.text = "— Time —"
	debug_content.add_child(debug_time_label)

	var btn_week := Button.new()
	btn_week.text = "[D] +1 Week"
	btn_week.pressed.connect(_advance_hours.bind(168))
	debug_content.add_child(btn_week)

	var projects_label := Label.new()
	projects_label.text = "— Projects —"
	debug_content.add_child(projects_label)

	var btn_force := Button.new()
	btn_force.text = "[D] Force Complete Top Project"
	btn_force.pressed.connect(_debug_force_complete_top_project)
	debug_content.add_child(btn_force)

	var state_label := Label.new()
	state_label.text = "— Game State —"
	debug_content.add_child(state_label)

	var btn_reset := Button.new()
	btn_reset.text = "[D] Reset Game"
	btn_reset.pressed.connect(_debug_reset_game)
	debug_content.add_child(btn_reset)


func _debug_set_supplies(value: float) -> void:
	var stockpile: Dictionary = GameState.hearthmere["stockpile"]
	if value < 0.0:
		var cap: float = StockpileSystem.get_good_cap(stockpile, "supplies")
		StockpileSystem.set_good_amount(stockpile, "supplies", cap)
		EventBus.add_event("[DEBUG] Supplies set to full (%.1f)." % cap)
	else:
		StockpileSystem.set_good_amount(stockpile, "supplies", value)
		EventBus.add_event("[DEBUG] Supplies set to %.1f." % value)
	_refresh_all_ui()


func _debug_adjust_supplies(delta: float) -> void:
	var stockpile: Dictionary = GameState.hearthmere["stockpile"]
	StockpileSystem.adjust_good_amount(stockpile, "supplies", delta)
	var new_val: float = StockpileSystem.get_good_amount(stockpile, "supplies")
	EventBus.add_event("[DEBUG] Supplies adjusted by %.1f → %.1f." % [delta, new_val])
	_refresh_all_ui()


func _debug_force_complete_top_project() -> void:
	_suppress_refresh = true
	ProjectSystem.force_complete_top_project()
	_suppress_refresh = false
	_refresh_all_ui()


func _debug_reset_game() -> void:
	get_tree().reload_current_scene()
