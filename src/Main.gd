extends Node2D

const player_state = preload("res://player_state.tres")

func _ready():
	player_state.tree = get_tree()

func _input(event):
	if event.is_action_pressed("g_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
