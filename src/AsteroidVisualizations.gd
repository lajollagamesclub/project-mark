extends Area2D

const player_state = preload("res://player_state.tres")

export var attaching_group = "asteroids"

var number_of_attached: int = 0 setget ,get_number_of_attached

func _process(delta):
	update()

func _draw():
	for b in get_bodies_in_group():
		var line_vector: Vector2 = to_local(b.global_position)
		var closeness_fraction: float = 1.2 - line_vector.length()/$CollisionShape2D.shape.radius
		var line_color: Color = Color(1, 1, 1)
		if player_state.fuel >= 99.0:
			line_color = Color("#60c1cc")
		line_color.a = closeness_fraction
		draw_line(Vector2(), line_vector, line_color, lerp(1.0, 20.0, closeness_fraction))

func get_number_of_attached() -> int:
	return get_bodies_in_group().size()

func get_bodies_in_group() -> Array:
	var to_return: Array = []
	for b in get_overlapping_bodies():
		if b.is_in_group(attaching_group):
			to_return.append(b)
	return to_return
