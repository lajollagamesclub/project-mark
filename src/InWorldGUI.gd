extends Control

class_name InWorldGUI

const player_state = preload("res://player_state.tres")

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector):
	rect_position += move_vector
