extends Node

signal event_added(message: String)

var event_log: Array[String] = []

func add_event(message: String) -> void:
	var game_hour: int = SimClock.game_hour
	var day: int = int(floor(float(game_hour) / 24.0)) + 1
	var hour_of_day: int = game_hour % 24
	var timestamp: String = "Day %d %02d:00" % [day, hour_of_day]
	var full_message: String = "%s — %s" % [timestamp, message]
	event_log.insert(0, full_message)
	emit_signal("event_added", full_message)

func get_recent_events(count: int) -> Array:
	var result: Array = []
	var limit: int = mini(count, event_log.size())
	for i in range(limit):
		result.append(event_log[i])
	return result
