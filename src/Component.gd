extends CenterContainer

class_name Component

var cooldown_time: float = 1.0 setget set_cooldown_time

var cur_cooldown_time: float = cooldown_time

func set_cooldown_time(new_cooldown_time):
	cooldown_time = new_cooldown_time
	if has_node("CooldownVisualizer"):
		$CooldownVisualizer.max_value = cooldown_time
		$CooldownVisualizer.step = cooldown_time/360.0

func _ready():
	self.cooldown_time = cooldown_time
	set_process(false)
	$CooldownVisualizer.visible = false

func _process(delta):
	cur_cooldown_time -= delta
	$CooldownVisualizer.value = cur_cooldown_time
	if cur_cooldown_time <= 0.0:
		$CooldownVisualizer.visible = false
		set_process(false)

func is_cooled_down() -> bool:
	return cur_cooldown_time <= 0.0

func start_cooldown():
	cur_cooldown_time = cooldown_time
	$CooldownVisualizer.visible = true
	set_process(true)
