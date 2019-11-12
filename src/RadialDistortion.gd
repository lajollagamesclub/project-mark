tool
extends SimpleQuad

const player_state = preload("res://player_state.tres")

export var reset = false setget set_reset

var direction: float = 1.0
var time: float = 0.0

func _ready():
	set_process(false)
	player_state.connect("hyperspace_changed", self, "_on_hyperspace_changed")
	material.set_shader_param("dist", 0.0)
#	into_hyperspace()

func set_reset(new_reset):
#	reset = new_reset
	time = 0.0
	set_process(true)

func _process(delta):
	if time >= 1.2:
#		time = 0.0
		if direction <= 0.0:
			material.set_shader_param("dist", 0.0)
		set_process(false)
	time += delta/4.0
	if direction > 0.0:
		material.set_shader_param("dist", time*direction)
	elif time < 1.2:
		material.set_shader_param("dist", 1.2 + time*direction)

func into_hyperspace():
	self.reset = true
	direction = 1.0

func outof_hyperspace():
	self.reset = true
	direction = -1.0

func _on_hyperspace_changed(new_hyperspace):
	if new_hyperspace:
		into_hyperspace()
	else:
		outof_hyperspace()
