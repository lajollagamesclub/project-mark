extends Area2D

var last_target_vector: Vector2 = Vector2()
var last_input_vector: Vector2 = Vector2()

# suggested rotation based on current target vector
# cur_vector - unit vector representing current direction
# toleration - angle in degrees for how much distance to tolerate
func get_suggestion(cur_vector: Vector2, toleration: float) -> float:
	cur_vector = cur_vector.normalized()
	last_input_vector = cur_vector
	toleration = deg2rad(toleration)
	
	var tolerated_vector = cur_vector.rotated(toleration)
	var tolerated_dot_product = 1 - tolerated_vector.dot(cur_vector)
	
	print(tolerated_dot_product)

	for n in get_overlapping_bodies():
		if n.is_in_group("targetable"):
			var to_n_vector: Vector2 = n.global_position - global_position
			to_n_vector = to_n_vector.normalized()
			var dot_to_target = to_n_vector.dot(cur_vector)
			if abs(dot_to_target) < tolerated_dot_product:
				last_target_vector = to_n_vector
				return to_n_vector.angle()
	
	return cur_vector.angle()

func _process(delta):
	update()

func _draw():
	draw_line(Vector2(),to_local(global_position + last_input_vector*3000.0), Color(1, 0, 0, 0.5), 10)
#	draw_line(Vector2(), last_target_vector*3000.0, Color(0, 1, 0, 0.5), 10.0)
