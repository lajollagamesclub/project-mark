extends Label

const game_state = preload("res://game_state.tres")

func _ready():
	game_state.cur_distance = 0

func _process(delta):
	text = str(game_state.cur_distance)