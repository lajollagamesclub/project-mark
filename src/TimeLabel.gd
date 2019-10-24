extends Label

const game_state = preload("res://game_state.tres")

func _ready():
	text = str("Time: ", game_state.time)