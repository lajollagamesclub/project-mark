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

func _physics_process(delta):
	if player_state.in_hyperspace and player_state.cur_distance >= player_state.max_distance - 500.0:
		player_state.in_hyperspace = !player_state.in_hyperspace
		start_cooldown()

func can_fire() -> bool:
	return player_state.cur_distance < player_state.max_distance - 500.0
