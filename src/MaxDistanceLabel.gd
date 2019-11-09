extends Label

const player_state = preload("res://player_state.tres")

func _process(delta):
	text = str(stepify(player_state.max_distance, 0.01))
