tool
extends Area2D

export var size: Vector2 = Vector2(10, 10) setget set_size
export var speed: float = 700.0

func _process(delta):
	global_position += Vector2(speed, 0).rotated(rotation)*delta

func set_size(new_size):
	new_size = Vector2(round(new_size.x), round(new_size.y))
	new_size.x = make_odd(new_size.x, size.x)
	new_size.y = make_odd(new_size.y, size.y)
	size = new_size
	if has_node("ColorRect") and \
		has_node("CollisionShape2D") and \
		has_node("VisibilityNotifier2D"):
		$ColorRect.rect_size = size*2
		$ColorRect.rect_position = -size
		$CollisionShape2D.shape.extents = size
		$VisibilityNotifier2D.rect = Rect2(-size, size*2)

func make_odd(new_size_component: float, old_size_component: float) -> float:
	if int(new_size_component) % 2 == 0:
		return new_size_component
	else:
		return new_size_component - sign(new_size_component - old_size_component)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()