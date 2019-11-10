extends InWorldKinematic

signal dead

const damage = 10.0

var despawn_distance: float = 8000.0
var player_node: Node2D

func _physics_process(delta):
	if player_node.global_position.distance_to(global_position) >= despawn_distance:
		emit_signal("dead")
		queue_free()
	look_at(player_node.global_position)
	# move_and_slide( Vector2 linear_velocity, Vector2 floor_normal=Vector2( 0, 0 ), bool stop_on_slope=false, int max_slides=4, float floor_max_angle=0.785398, bool infinite_inertia=tru
	
	var velocity: Vector2 = Vector2(700, 0).rotated(rotation)
	
	move_and_slide(velocity, Vector2(), false, 4, 0.78, false)

	for c in range(get_slide_count()):
		var collision = get_slide_collision(c)
		if collision.collider.is_in_group("player"):
			player_state.health -= damage
			queue_free()
#			get_tree().change_scene("res://GameOver.tscn")

func hit():
	queue_free()
	emit_signal("dead")
