extends Component

const player_state = preload("res://player_state.tres")


func _ready():
	self.cooldown_time = 3.0

func on_trigger() -> bool:
	self.cooldown_time = 3.0
	print($VBoxContainer/CenterContainer/CooldownVisualizer.max_value)
	if not is_cooled_down():
		return false
	player_state.in_hyperspace = true
	$Timer.start()
	start_cooldown()
	return true


func _on_Timer_timeout():
	player_state.in_hyperspace = false
