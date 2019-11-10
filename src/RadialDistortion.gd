tool
extends SimpleQuad

var time: float = 0.0

func _process(delta):
	if time >= 1.0:
		time = 0.0
	time += delta/2.0
	material.set_shader_param("dist", time)
