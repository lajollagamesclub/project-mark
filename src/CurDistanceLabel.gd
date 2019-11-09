extends Label

const player_state = preload("res://player_state.tres")

func _ready():
	player_state.cur_distance = 0

func _process(delta):
	text = str(round(player_state.cur_distance))