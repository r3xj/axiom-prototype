extends Node

signal hour_advanced(new_hour: int)
signal hours_advanced
signal simulation_time_advanced(delta_sim_hours: float)
signal playback_changed

const HOURS_PER_DAY: int = 24

var game_hour: int = 8
var is_paused: bool = true
var speed_multiplier: float = 1.0
var _pending_sim_hours: float = 0.0


func _process(delta: float) -> void:
	if is_paused:
		return

	var delta_sim_hours: float = delta * speed_multiplier
	_pending_sim_hours += delta_sim_hours
	emit_signal("simulation_time_advanced", delta_sim_hours)

	while _pending_sim_hours >= 1.0:
		_pending_sim_hours -= 1.0
		game_hour += 1
		emit_signal("hour_advanced", game_hour)
		emit_signal("hours_advanced")


func advance_hours(count: int) -> void:
	for i in range(count):
		game_hour += 1
		emit_signal("simulation_time_advanced", 1.0)
		emit_signal("hour_advanced", game_hour)
	emit_signal("hours_advanced")


func set_paused(paused: bool) -> void:
	if is_paused == paused:
		return
	is_paused = paused
	emit_signal("playback_changed")


func toggle_paused() -> void:
	set_paused(not is_paused)


func set_speed_multiplier(multiplier: float) -> void:
	speed_multiplier = maxf(multiplier, 0.0)
	emit_signal("playback_changed")

func get_day_number() -> int:
	return int(floor(float(game_hour) / float(HOURS_PER_DAY))) + 1

func get_hour_of_day() -> int:
	return game_hour % HOURS_PER_DAY
