extends KinematicBody2D

class_name InWorldKinematic

const player_state = preload("res://player_state.tres")

var infinite_inertia: bool = true

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector):
	move_and_collide(move_vector, infinite_inertia)
