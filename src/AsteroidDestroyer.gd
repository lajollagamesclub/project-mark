extends Area2D

signal bumped

func _on_AsteroidDestroyer_body_entered(body):
	if body.is_in_group("asteroids"):
		emit_signal("bumped")
		body.explode()
