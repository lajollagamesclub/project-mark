extends Label

const game_state = preload("res://game_state.tres")

func _process(delta):
	text = str(stepify(game_state.distance, 0.01))
