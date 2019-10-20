extends RigidBody2D

signal dead

var despawn_distance: float = 500.0
var player_node: Node2D

func _physics_process(delta):
	if player_node.global_position.distance_to(global_position) >= despawn_distance:
		emit_signal("dead")
		queue_free()
	applied_force = (player_node.global_position - global_position).normalized()*800.0
#	move_and_slide((player_node.global_position - global_position).normalized()*600.0)