extends Label

const game_state = preload("res://game_state.tres")

func _process(delta):
	text = str("Current Time: ", game_state.time)