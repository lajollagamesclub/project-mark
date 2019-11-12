extends Component

const player_state = preload("res://player_state.tres")


func _ready():
	self.cooldown_time = 3.0

func on_trigger() -> bool:
	self.cooldown_time = 3.0
	if not is_cooled_down():
		return false
	player_state.in_hyperspace = !player_state.in_hyperspace
	start_cooldown()
	return true
