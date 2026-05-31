extends Control

const DEBUG_MODE: bool = true
const ScenarioData: GDScript = preload("res://scripts/scenario_data.gd")

var selected_region_id: String = "hearthmere"
var _suppress_refresh: bool = false

var time_label: Label
var info_title: Label
var info_body: Label
var economy_body: Label
var prospects_body: Label
var prospect_buttons_box: VBoxContainer
var region_action_buttons_box: VBoxContainer
var projects_body: Label
var shipments_body: Label
var event_log_body: Label
var supply_minus_button: Button
var supply_plus_button: Button
var codex_body: Label
var map_debug_body: Label

var region_buttons: Dictionary = {}
var _map_canvas: MapCanvas


func _ready() -> void:
	_clear_existing_children()
	_build_ui()

	GameState.state_changed.connect(_on_state_changed)
	ProjectSystem.state_changed.connect(_on_state_changed)
	LogisticsSystem.state_changed.connect(_on_state_changed)
	CodexSystem.state_changed.connect(_on_state_changed)
	StrategicMap.entity_changed.connect(_on_strategic_map_changed)
	StrategicMap.selected_entity_changed.connect(_on_strategic_map_changed)
	SimClock.hours_advanced.connect(_on_hours_advanced)

	EventBus.add_event("Scenario started. Hearthmere surveys its known surroundings.")
	_refresh_all_ui()


func _on_state_changed() -> void:
	if not _suppress_refresh:
		_refresh_all_ui()


func _on_hours_advanced() -> void:
	_refresh_all_ui()


func _on_strategic_map_changed() -> void:
	if _map_canvas:
		_map_canvas.queue_redraw()
	if map_debug_body:
		_refresh_map_debug_panel()


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
	map_panel.custom_minimum_size = Vector2(460, 540)
	map_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	map_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	parent.add_child(map_panel)

	var map_content := VBoxContainer.new()
	map_content.name = "MapContent"
	map_panel.add_child(map_content)

	var map_title := Label.new()
	map_title.text = "Known Local Region"
	map_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	map_content.add_child(map_title)

	var canvas := MapCanvas.new()
	canvas.name = "MapCanvas"
	canvas.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	canvas.size_flags_vertical = Control.SIZE_EXPAND_FILL
	canvas.custom_minimum_size = Vector2(460, 520)
	map_content.add_child(canvas)
	canvas.setup(self)

	_map_canvas = canvas


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

	region_action_buttons_box = VBoxContainer.new()
	region_action_buttons_box.name = "RegionActionButtons"
	region_action_buttons_box.add_theme_constant_override("separation", 6)
	info_content.add_child(region_action_buttons_box)


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
	_refresh_map_debug_panel()


func _refresh_time_label() -> void:
	time_label.text = "Day %d — %02d:00" % [SimClock.get_day_number(), SimClock.get_hour_of_day()]


func _refresh_region_panel() -> void:
	var region: Dictionary = GameState.regions[selected_region_id]

	info_title.text = region["name"]

	var known_text := ""
	for item in region["known_contents"]:
		known_text += "- %s\n" % item

	info_body.text = (
		"Type: %s\n"
		+ "Status: %s\n\n"
		+ "%s\n\n"
		+ "Known Contents:\n%s"
	) % [
		region["type"],
		region["status"],
		region["description"],
		known_text.strip_edges(),
	]

	_clear_container_children(region_action_buttons_box)

	if selected_region_id == "hearthmere" and CodexSystem.redglass_known and not CodexSystem.redglass_tested:
		var already_running := false
		for p in ProjectSystem.active_projects:
			if str(p["type"]) == "analyze_material":
				already_running = true
				break

		if not already_running:
			var ore_in_stockpile: float = StockpileSystem.get_good_amount(GameState.hearthmere["stockpile"], "redglass_ore")
			if ore_in_stockpile > 0.0:
				var btn := Button.new()
				btn.text = "Analyze Redglass Ore (2d, 1 labor, 5 ore)"
				btn.disabled = _get_unassigned_labor_teams() < 1 or ore_in_stockpile < 5.0
				btn.pressed.connect(_start_analysis_project)
				region_action_buttons_box.add_child(btn)


	if selected_region_id == "hearthmere" and CodexSystem.redglass_tested:
		var forge_costs: Dictionary = ScenarioData.get_forge_material_costs()
		var ore_available: float = StockpileSystem.get_good_amount(GameState.hearthmere["stockpile"], "redglass_ore")

		var blade_ore_cost: float = float(forge_costs.get("redglass_blade", {}).get("redglass_ore", 0.0))
		var btn_blade := Button.new()
		btn_blade.text = "Forge Redglass Blade (24h, 1 labor, 10 ore)"
		btn_blade.disabled = _get_unassigned_labor_teams() < 1 or ore_available < blade_ore_cost
		btn_blade.pressed.connect(_start_forge_project.bind("redglass_blade"))
		region_action_buttons_box.add_child(btn_blade)

		var armor_ore_cost: float = float(forge_costs.get("redglass_armor_piece", {}).get("redglass_ore", 0.0))
		var btn_armor := Button.new()
		btn_armor.text = "Forge Redglass Armor Piece (36h, 1 labor, 15 ore)"
		btn_armor.disabled = _get_unassigned_labor_teams() < 1 or ore_available < armor_ore_cost
		btn_armor.pressed.connect(_start_forge_project.bind("redglass_armor_piece"))
		region_action_buttons_box.add_child(btn_armor)


func _refresh_region_buttons() -> void:
	if _map_canvas:
		_map_canvas.refresh(selected_region_id)


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
	var mine_worker_teams: int = GameState.get_mine_worker_teams()
	var unassigned_labor_teams: int = _get_unassigned_labor_teams()
	var daily_supply_output: float = GameState.supply_production_labor_teams * float(GameState.hearthmere["supply_production_per_team_per_day"])

	var labor_block := "LABOR\n"
	labor_block += "Total: %d  |  Unassigned: %d\n" % [total_labor_teams, unassigned_labor_teams]
	labor_block += "Supply: %d  |  Projects: %d  |  Shipments: %d  |  Mine: %d\n" % [
		GameState.supply_production_labor_teams, project_labor_teams, shipment_labor_teams, mine_worker_teams,
	]
	labor_block += "Supply output: %.1f / day" % daily_supply_output

	var stockpile_block := "HEARTHMERE STOCKPILE\n"
	for good_key in GameState.hearthmere["stockpile"]["goods"].keys():
		var amount: float = StockpileSystem.get_good_amount(GameState.hearthmere["stockpile"], good_key)
		var cap: float = StockpileSystem.get_good_cap(GameState.hearthmere["stockpile"], good_key)
		var display: String = CodexSystem.get_display_name(str(good_key))
		var bar: String = _ascii_bar(amount, cap, 10)
		stockpile_block += "%-18s %6.1f / %-6.1f %s\n" % [display + ":", amount, cap, bar]
	stockpile_block = stockpile_block.strip_edges()

	var manpower_block := "MANPOWER\n"
	manpower_block += "Population: %d  |  Defense: %d" % [
		int(GameState.hearthmere["population"]),
		int(GameState.hearthmere["settlement_defense"]),
	]

	economy_body.text = labor_block + "\n\n" + stockpile_block + "\n\n" + manpower_block

	supply_minus_button.disabled = GameState.supply_production_labor_teams <= 0
	supply_plus_button.disabled = unassigned_labor_teams <= 0


func _refresh_projects_panel() -> void:
	if ProjectSystem.active_projects.is_empty():
		projects_body.text = "No active projects."
		return

	var text := ""
	for project in ProjectSystem.active_projects:
		text += "%s — %s remaining (%d team)\n" % [
			str(project["title"]),
			_format_hours(int(project["remaining_hours"])),
			int(project["labor_teams"]),
		]

	projects_body.text = text.strip_edges()


func _refresh_shipments_panel() -> void:
	if LogisticsSystem.active_shipments.is_empty():
		shipments_body.text = "No active shipments."
		return

	var text := ""
	for shipment in LogisticsSystem.active_shipments:
		var destination_id: String = str(shipment["destination"])
		var route_id: String = str(shipment["route"])
		var dest_name: String = LogisticsSystem.get_location_name(destination_id)
		var route_name: String = str(LogisticsSystem.ROUTES[route_id]["name"])

		var cargo: Dictionary = shipment["cargo"]
		var cargo_summary := ""
		for good_key in cargo.keys():
			if not cargo_summary.is_empty():
				cargo_summary += ", "
			cargo_summary += CodexSystem.get_display_name(str(good_key))

		text += "%s → %s via %s — %s / %s\n" % [
			cargo_summary,
			dest_name,
			route_name,
			_format_hours(int(shipment["progress_hours"])),
			_format_hours(int(shipment["total_hours"])),
		]

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


func _ascii_bar(amount: float, cap: float, width: int) -> String:
	if cap <= 0.0:
		return "[" + " ".repeat(width) + "]"
	var filled: int = int(clampf(amount / cap, 0.0, 1.0) * float(width))
	return "[" + "=".repeat(filled) + " ".repeat(width - filled) + "]"


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


func _start_analysis_project() -> void:
	ProjectSystem.start_analysis_project()


func _start_forge_project(output_type: String) -> void:
	var costs: Dictionary = ScenarioData.get_forge_material_costs()
	var material_inputs: Dictionary = costs.get(output_type, {}).duplicate()
	ProjectSystem.start_forge_project(output_type, material_inputs)


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

	var map_label := Label.new()
	map_label.text = "— Strategic Map —"
	debug_content.add_child(map_label)

	var btn_caravan := Button.new()
	btn_caravan.text = "[D] Select Caravan"
	btn_caravan.pressed.connect(_debug_select_map_entity.bind("debug_caravan"))
	debug_content.add_child(btn_caravan)

	var btn_army := Button.new()
	btn_army.text = "[D] Select Army"
	btn_army.pressed.connect(_debug_select_map_entity.bind("debug_army"))
	debug_content.add_child(btn_army)

	map_debug_body = Label.new()
	map_debug_body.text = ""
	map_debug_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	debug_content.add_child(map_debug_body)


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


func _debug_select_map_entity(entity_id: String) -> void:
	StrategicMap.select_entity(entity_id)
	_refresh_map_debug_panel()
	if _map_canvas:
		_map_canvas.queue_redraw()


func _refresh_map_debug_panel() -> void:
	if not map_debug_body:
		return
	if not StrategicMap.entities.has(StrategicMap.selected_entity_id):
		map_debug_body.text = "No selected strategic entity."
		return

	var entity: Dictionary = StrategicMap.entities[StrategicMap.selected_entity_id]
	var world_position: Vector2 = entity["world_position"] as Vector2
	var cell: Vector2i = StrategicMap.world_to_cell(world_position)
	var context: Dictionary = StrategicMap.get_tactical_context(world_position)
	var path_points: Array = entity["path_points"]

	map_debug_body.text = (
		"Selected: %s (%s)\n"
		+ "World: %.1f, %.1f\n"
		+ "Cell: %d, %d\n"
		+ "Terrain: %s  Road: %s  Blocked: %s\n"
		+ "Path points: %d\n"
		+ "Click map background to command movement."
	) % [
		str(entity["display_name"]),
		str(entity["profile_id"]),
		world_position.x,
		world_position.y,
		cell.x,
		cell.y,
		str(context["terrain"]),
		str(context["has_road"]),
		str(context["blocked"]),
		path_points.size(),
	]


class MapCanvas extends Control:
	var _main: Node
	var _region_buttons: Dictionary = {}

	func _draw() -> void:
		_draw_terrain_grid()
		_draw_current_path()
		_draw_pois()
		_draw_entities()


	func _gui_input(event: InputEvent) -> void:
		var mouse_button := event as InputEventMouseButton
		if mouse_button == null:
			return
		if not mouse_button.pressed or mouse_button.button_index != MOUSE_BUTTON_LEFT:
			return

		var destination: Vector2 = StrategicMap.clamp_world_position(mouse_button.position)
		var moved: bool = StrategicMap.command_selected_entity(destination)
		if moved:
			var context: Dictionary = StrategicMap.get_tactical_context(destination)
			EventBus.add_event("[DEBUG] Move command: %s to %s cell %s." % [
				StrategicMap.selected_entity_id,
				str(context["context_type"]),
				str(context["cell"]),
			])
			if _main:
				_main._refresh_map_debug_panel()
		else:
			EventBus.add_event("[DEBUG] No valid path to selected map destination.")


	func _draw_terrain_grid() -> void:
		for y in range(StrategicMap.grid_size.y):
			for x in range(StrategicMap.grid_size.x):
				var cell := Vector2i(x, y)
				var data: Dictionary = StrategicMap.get_cell_data(cell)
				var rect := Rect2(
					Vector2(float(x * StrategicMap.cell_size), float(y * StrategicMap.cell_size)),
					Vector2(float(StrategicMap.cell_size), float(StrategicMap.cell_size))
				)
				draw_rect(rect, _terrain_color(str(data["terrain"]), bool(data["blocked"])))
				if bool(data["has_road"]):
					draw_rect(rect.grow(-12.0), Color(0.78, 0.66, 0.34, 0.9))
				draw_rect(rect, Color(0.08, 0.08, 0.08, 0.35), false, 1.0)


	func _terrain_color(terrain: String, blocked: bool) -> Color:
		if blocked:
			return Color(0.08, 0.08, 0.09, 0.95)
		match terrain:
			"forest":
				return Color(0.18, 0.36, 0.22, 0.88)
			"hills":
				return Color(0.46, 0.38, 0.26, 0.88)
			"mountain":
				return Color(0.36, 0.36, 0.38, 0.88)
			"water":
				return Color(0.14, 0.32, 0.48, 0.88)
			_:
				return Color(0.30, 0.42, 0.28, 0.88)


	func _draw_current_path() -> void:
		if not StrategicMap.entities.has(StrategicMap.selected_entity_id):
			return
		var entity: Dictionary = StrategicMap.entities[StrategicMap.selected_entity_id]
		var points: Array = entity["path_points"]
		if points.size() < 2:
			return
		for i in range(points.size() - 1):
			var a: Vector2 = points[i] as Vector2
			var b: Vector2 = points[i + 1] as Vector2
			draw_line(a, b, Color(0.95, 0.95, 0.2), 3.0)


	func _draw_pois() -> void:
		var font: Font = get_theme_default_font()
		for poi_id in StrategicMap.pois.keys():
			var poi: Dictionary = StrategicMap.pois[poi_id]
			var pos: Vector2 = poi["world_position"] as Vector2
			var poi_type: String = str(poi["poi_type"])
			var color: Color = Color(0.85, 0.85, 0.85)
			if poi_type == "prospect":
				color = Color(0.95, 0.45, 0.28)
			elif poi_type == "settlement":
				color = Color(0.32, 0.72, 1.0)
			elif poi_type == "route_landmark":
				color = Color(0.9, 0.76, 0.34)
			draw_circle(pos, 5.0, color)
			if poi_type == "prospect":
				draw_string(font, pos + Vector2(8, -8), str(poi["display_name"]), HORIZONTAL_ALIGNMENT_LEFT, -1.0, 11)


	func _draw_entities() -> void:
		var font: Font = get_theme_default_font()
		for entity_id in StrategicMap.entities.keys():
			var entity: Dictionary = StrategicMap.entities[entity_id]
			var pos: Vector2 = entity["world_position"] as Vector2
			var profile_id: String = str(entity["profile_id"])
			var color: Color = Color(1.0, 0.86, 0.22)
			if profile_id == "army":
				color = Color(0.92, 0.22, 0.22)
			if str(entity_id) == StrategicMap.selected_entity_id:
				draw_circle(pos, 10.0, Color(1.0, 1.0, 1.0, 0.65))
			draw_circle(pos, 7.0, color)
			draw_string(font, pos + Vector2(10, 4), str(entity["display_name"]), HORIZONTAL_ALIGNMENT_LEFT, -1.0, 12)

	func setup(main: Node) -> void:
		_main = main
		_region_buttons.clear()

		for region_id in GameState.region_order:
			var btn := Button.new()
			btn.name = "RegionBtn_%s" % region_id
			btn.custom_minimum_size = Vector2(110, 48)
			btn.pressed.connect(main._select_region.bind(region_id))
			add_child(btn)

			var pos: Vector2 = StrategicMap.get_poi_world_position(region_id)
			btn.position = pos - Vector2(55, 24)

			_region_buttons[region_id] = btn

	func refresh(selected_region_id: String) -> void:
		for region_id in _region_buttons.keys():
			var btn: Button = _region_buttons[region_id]
			btn.disabled = (region_id == selected_region_id)

			btn.text = GameState.regions[region_id]["name"]

		queue_redraw()
