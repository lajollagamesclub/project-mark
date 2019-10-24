extends ProgressBar

const player_state = preload("res://player_state.tres")

func _ready():
	player_state.connect("fuel_changed", self, "_on_fuel_change")
	value = float(player_state.fuel)

func _on_fuel_change(new_fuel):
	value = float(new_fuel)