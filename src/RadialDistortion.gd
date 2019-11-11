tool
extends SimpleQuad

export var reset = false setget set_reset

var direction: float = 1.0

func _ready():
	set_process(false)
	material.set_shader_param("dist", 0.0)

func set_reset(new_reset):
#	reset = new_reset
	time = 0.0
	set_process(true)

var time: float = 0.0

func _process(delta):
	if time >= 1.2:
#		time = 0.0
		set_process(false)
	time += delta/4.0
	material.set_shader_param("dist", time*direction)

func into_hyperspace():
	self.reset = true
	direction = 1.0

func outof_hyperspace():
	self.reset = true
	direction = -1.0
