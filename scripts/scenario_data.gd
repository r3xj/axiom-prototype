extends RefCounted

const HEARTHMERE_STARTING_VALUES: Dictionary = {
	"population": 240,
	"available_workforce": 120,
	"labor_team_size": 20,
	"mobilized_manpower": 0,
	"recovering": 0,
	"recent_losses": 0,
	"supply_production_per_team_per_day": 12.0,
	"stockpile": {
		"goods": {
			"supplies": {"amount": 60.0, "cap": 100.0},
		}
	},
	"settlement_defense": 12,
}

const MATERIAL_CODEX_DEFAULTS: Dictionary = {
	"redglass_ore": {
		"name": "Redglass Ore",
		"status": "Undiscovered",
		"known_source": "Unknown",
		"observed_traits": [],
		"tested_properties": [],
		"known_uses": [],
		"field_notes": [],
		"unresolved_questions": [],
	}
}

const REDGLASS_DISCOVERED_CODEX_ENTRY: Dictionary = {
	"name": "Redglass Ore",
	"status": "Known / Untested",
	"known_source": "Redglass Foothills",
	"observed_traits": [
		"Red, glassy mineral seam",
		"Local workers do not recognize it",
		"Surface samples are stable enough to transport",
	],
	"tested_properties": [],
	"known_uses": [
		"Unknown",
	],
	"field_notes": [],
	"unresolved_questions": [
		"Weapon suitability unknown",
		"Armor/shield suitability unknown",
		"Thermal response unknown",
		"Workability unknown",
		"Value/appeal unknown",
	],
}

const REDGLASS_TESTED_CODEX_ENTRY: Dictionary = {
	"name": "Redglass Ore",
	"status": "Known / Tested",
	"known_source": "Redglass Foothills",
	"observed_traits": [
		"Red, glassy mineral seam",
		"Local workers do not recognize it",
		"Surface samples are stable enough to transport",
	],
	"tested_properties": [
		"Hardness: Moderate. Workable with standard forge tools.",
		"Thermal response: Holds heat unusually well. Slow to cool.",
		"Structural integrity: Dense. Resists fracture under compression.",
		"Edge retention: Promising. Holds a grind without flaking.",
	],
	"known_uses": [
		"Potential weapon material — edge retention and hardness suggest bladed use.",
		"Potential armor material — density and thermal properties warrant further trials.",
	],
	"field_notes": [
		"Academy staff note an unfamiliar crystalline structure. Source is volcanic or deeper.",
	],
	"unresolved_questions": [
		"Full weapon output requires forge project.",
		"Armor suitability unconfirmed without craft trial.",
		"Long-term thermal behavior under sustained use unknown.",
	],
}

const PROSPECTS: Dictionary = {
	"red_seam": {
		"name": "Unusual Red Seam",
		"region_id": "redglass_foothills",
		"status": "unsurveyed",
		"survey_hours": 24,
		"visible_clue": "A thin red mineral line is visible in exposed foothill stone. Local workers do not recognize it.",
		"outcome": "redglass_deposit",
		"result_text": "Surveyors confirm a workable deposit of unfamiliar red, glassy ore.",
		"produces": "redglass_ore",
	},
	"dark_gravel": {
		"name": "Dark Gravel Wash",
		"region_id": "redglass_foothills",
		"status": "unsurveyed",
		"survey_hours": 12,
		"visible_clue": "A dry wash contains dark metallic gravel. It may be useful, or it may just be common stone stained by runoff.",
		"outcome": "mundane",
		"result_text": "The dark gravel is mundane stone and poor-quality surface iron. It is not worth developing for Phase 1A.",
	},
	"old_dig": {
		"name": "Abandoned Dig Marks",
		"region_id": "redglass_foothills",
		"status": "unsurveyed",
		"survey_hours": 16,
		"visible_clue": "Old tool marks scar a hillside. Someone once thought this slope was worth digging.",
		"outcome": "false",
		"result_text": "The old dig is exhausted. Surveyors find traces of prior extraction but no useful remaining deposit.",
	},
}

const REGION_ORDER: Array[String] = [
	"silent_border",
	"blackbanner_camp",
	"ashen_pass",
	"hearthmere",
	"redglass_foothills",
	"old_pine_road",
	"westmere_farms",
]

const REGIONS: Dictionary = {
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
			"Inspect prospect leads",
			"Begin survey project",
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


const FORGE_OUTPUTS: Dictionary = {
	"redglass_blade": {
		"name": "Redglass Blade",
		"output_type": "redglass_blade",
		"required_material_type": "ore",
		"duration_hours": 24,
		"labor_teams": 1,
		"produces_good": "redglass_blade",
		"produces_amount": 1.0,
		"stockpile_cap": 500.0,
	},
	"redglass_armor_piece": {
		"name": "Redglass Armor Piece",
		"output_type": "redglass_armor_piece",
		"required_material_type": "ore",
		"duration_hours": 36,
		"labor_teams": 1,
		"produces_good": "redglass_armor_piece",
		"produces_amount": 1.0,
		"stockpile_cap": 500.0,
	},
}

const FORGE_MATERIAL_COSTS: Dictionary = {
	"redglass_blade": {
		"redglass_ore": 10.0,
	},
	"redglass_armor_piece": {
		"redglass_ore": 15.0,
	},
}


static func get_hearthmere_starting_values() -> Dictionary:
	return HEARTHMERE_STARTING_VALUES.duplicate(true)


static func get_material_codex_defaults() -> Dictionary:
	return MATERIAL_CODEX_DEFAULTS.duplicate(true)


static func get_redglass_discovered_codex_entry() -> Dictionary:
	return REDGLASS_DISCOVERED_CODEX_ENTRY.duplicate(true)


static func get_redglass_tested_codex_entry() -> Dictionary:
	return REDGLASS_TESTED_CODEX_ENTRY.duplicate(true)


static func get_prospects() -> Dictionary:
	return PROSPECTS.duplicate(true)


static func get_region_order() -> Array[String]:
	var region_order: Array[String] = []
	region_order.assign(REGION_ORDER)
	return region_order


static func get_regions() -> Dictionary:
	return REGIONS.duplicate(true)


static func get_forge_outputs() -> Dictionary:
	return FORGE_OUTPUTS.duplicate(true)


static func get_forge_material_costs() -> Dictionary:
	return FORGE_MATERIAL_COSTS.duplicate(true)
