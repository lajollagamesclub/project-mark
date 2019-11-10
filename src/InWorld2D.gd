extends Node2D

class_name InWorld2D

const player_state = preload("res://player_state.tres")


func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector):
	global_position += move_vector
