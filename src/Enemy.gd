tool
extends RigidBody2D

signal dead

export var size: int = 30 setget set_size

var despawn_distance: float = 500.0
var player_node: Node2D

func set_size(new_size):
	if new_size % 2 != 0:
		new_size -= sign(size - new_size)
	size = new_size
	if has_node("ColorRect") and has_node("CollisionShape2D"):
		var size_vector = Vector2(size, size)
		$ColorRect.rect_size = size_vector
		$ColorRect.rect_position = -size_vector/2
		$CollisionShape2D.shape.extents = size_vector/2

func _ready():
	if Engine.editor_hint:
		set_physics_process(false)
		set_process(false)

func _physics_process(delta):
	if player_node.global_position.distance_to(global_position) >= despawn_distance:
		emit_signal("dead")
		queue_free()
#	applied_force = (player_node.global_position - global_position).normalized()*800.0
#	move_and_slide((player_node.global_position - global_position).normalized()*600.0)