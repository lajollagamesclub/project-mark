extends Component

const player_state = preload("res://player_state.tres")


func _ready():
	self.cooldown_time = 2.5

func on_trigger() -> bool:
	self.cooldown_time = 2.5
	if not is_cooled_down():
		return false
	player_state.dashing = true
	start_cooldown()
	$Timer.start()
	$AudioStreamPlayer.play()
	return true

func can_fire() -> bool:
	return !player_state.in_hyperspace


func _on_Timer_timeout():
	player_state.dashing = false
