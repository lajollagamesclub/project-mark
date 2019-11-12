extends CenterContainer

class_name Component

var cooldown_time: float = 1.0 setget set_cooldown_time
var cur_cooldown_time: float = 0.0
var number: int = 0 setget set_number

onready var cooldown_visualizer = $VBoxContainer/CenterContainer/CooldownVisualizer



func set_number(new_number):
	number = new_number
	if has_node("VBoxContainer/NumberLabel"):
		$VBoxContainer/NumberLabel.text = str(number)


func set_cooldown_time(new_cooldown_time):
	cooldown_time = new_cooldown_time
	if has_node("VBoxContainer/CenterContainer/CooldownVisualizer"):
		cooldown_visualizer.max_value = cooldown_time
		cooldown_visualizer.step = cooldown_time/360.0

func _ready():
	self.cooldown_time = cooldown_time
	set_process(false)
	cooldown_visualizer.visible = false

func _process(delta):
	cur_cooldown_time -= delta
	cooldown_visualizer.value = cur_cooldown_time
	if cur_cooldown_time <= 0.0:
		cooldown_visualizer.visible = false
		set_process(false)

func is_cooled_down() -> bool:
	return cur_cooldown_time <= 0.0 and can_fire()

func start_cooldown():
	cur_cooldown_time = cooldown_time
	cooldown_visualizer.visible = true
	set_process(true)

func on_trigger():
	printerr("The on_trigger be overloaded in component " + name)

func can_fire():
	printerr("The can_fire method must be overloaded in component " + name)
