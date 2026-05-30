extends Node

signal hour_advanced(new_hour: int)
signal hours_advanced

const HOURS_PER_DAY: int = 24

var game_hour: int = 8

func advance_hours(count: int) -> void:
	for i in range(count):
		game_hour += 1
		emit_signal("hour_advanced", game_hour)
	emit_signal("hours_advanced")

func get_day_number() -> int:
	return int(floor(float(game_hour) / float(HOURS_PER_DAY))) + 1

func get_hour_of_day() -> int:
	return game_hour % HOURS_PER_DAY
