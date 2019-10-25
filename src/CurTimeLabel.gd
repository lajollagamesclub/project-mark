extends Label

const game_state = preload("res://game_state.tres")

func _process(delta):
	text = str("Current Time: ", stepify(game_state.time, 0.01))