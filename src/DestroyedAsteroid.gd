extends InWorld2D

onready var fragments_node: Node2D = $Fragments

func _process(delta):
	modulate.a -= 0.5*delta
	if modulate.a <= 0.0:
		queue_free()
