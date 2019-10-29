extends Node2D

const game_state = preload("res://game_state.tres")

func _process(delta):
	game_state.time += delta

func _input(event):
	if event.is_action_pressed("g_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
