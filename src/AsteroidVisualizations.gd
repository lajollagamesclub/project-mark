extends Area2D

export var attaching_group = "asteroids"

var number_of_attached: int = 0 setget ,get_number_of_attached

func _process(delta):
	update()

func _draw():
	for b in get_bodies_in_group():
		var line_vector: Vector2 = to_local(b.global_position)
		draw_line(Vector2(), line_vector, Color(1, 0, 0, 1.0 - line_vector.length()/$CollisionShape2D.shape.radius), 10.0)

func get_number_of_attached() -> int:
	return get_bodies_in_group().size()

func get_bodies_in_group() -> Array:
	var to_return: Array = []
	for b in get_overlapping_bodies():
		if b.is_in_group(attaching_group):
			to_return.append(b)
	return to_return