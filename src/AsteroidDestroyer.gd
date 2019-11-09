extends Area2D

signal bumped

var disabled: bool = false setget set_disabled

func _on_AsteroidDestroyer_body_entered(body):
	if body.is_in_group("asteroids"):
		emit_signal("bumped")
		body.explode()


func set_disabled(new_disabled):
	disabled = new_disabled
	$CollisionPolygon2D.disabled = new_disabled
