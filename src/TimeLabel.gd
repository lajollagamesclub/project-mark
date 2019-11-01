extends Label

const game_state = preload("res://game_state.tres")

func _ready():
	text = str("Largest Distance: ", stepify(game_state.distance, 0.01))
