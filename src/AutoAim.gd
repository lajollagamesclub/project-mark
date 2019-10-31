extends Area2D

# suggested rotation based on current target vector
# cur_vector - unit vector representing current direction
# toleration - angle in degrees for how much distance to tolerate
func get_suggestion(cur_vector: Vector2, toleration: float) -> float:
	cur_vector = cur_vector.normalized()
	toleration = deg2rad(toleration)
	
	var tolerated_vector = cur_vector.rotated(toleration)
	var tolerated_dot_product = 1 - abs(tolerated_vector.dot(cur_vector))

	var sorted_by_distance: Array = get_overlapping_bodies()
	sorted_by_distance.sort_custom(self, "sort_by_distance")
	for n in sorted_by_distance:
		if n.is_in_group("targetable"):
			var to_n_vector: Vector2 = n.global_position - global_position
			to_n_vector = to_n_vector.normalized()
			var dot_to_target = 1 - abs(max(0,to_n_vector.dot(cur_vector)))
			if abs(dot_to_target) < tolerated_dot_product:
				return to_n_vector.angle()
	
	return cur_vector.angle()

func sort_by_distance(first_node: Node2D, second_node: Node2D):
	var first_distance: float = (first_node.global_position - global_position).length()
	var second_distance: float = (second_node.global_position - global_position).length()

	return first_distance < second_distance
