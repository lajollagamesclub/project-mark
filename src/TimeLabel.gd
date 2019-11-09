extends Label

const player_state = preload("res://player_state.tres")

func _ready():
	text = str("Largest Distance: ", stepify(player_state.distance, 0.01))
