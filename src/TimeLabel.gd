extends Label

const game_state = preload("res://game_state.tres")

func _ready():
	text = str("Time: ", stepify(game_state.time, 0.01))
