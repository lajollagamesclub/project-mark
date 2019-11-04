tool
extends RigidBody2D

signal dead

export var size: int = 30 setget set_size

var despawn_distance: float = 500.0
var player_node: Node2D
var resource_amount: float = 1.0 setget set_resource_amount


func _ready():
	if Engine.editor_hint:
		set_physics_process(false)
		set_process(false)
	else:
		$Sprite.rotation = rand_range(0, 2*PI)

func set_resource_amount(new_resource_amount):
	resource_amount = new_resource_amount
	modulate = lerp(Color(0, 0, 0), Color(1, 1, 1), resource_amount)

func set_size(new_size):
	if new_size % 2 != 0:
		new_size -= sign(size - new_size)
	size = new_size
	if has_node("ColorRect") and has_node("CollisionShape2D"):
		var size_vector = Vector2(size, size)
		$ColorRect.rect_size = size_vector
		$ColorRect.rect_position = -size_vector/2
		$CollisionShape2D.shape.extents = size_vector/2


func _process(delta):
	if resource_amount < 1.0:
		self.resource_amount += delta*0.5

func tap_resource(delta) -> bool:
	if resource_amount > 0.0:
		self.resource_amount -= delta + delta*0.5
		return true
	else:
		return false

func _physics_process(delta):
	if player_node.global_position.distance_to(global_position) >= despawn_distance:
		emit_signal("dead")
		queue_free()
#	applied_force = (player_node.global_position - global_position).normalized()*800.0
#	move_and_slide((player_node.global_position - global_position).normalized()*600.0)