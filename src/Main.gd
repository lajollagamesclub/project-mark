extends Node2D

func _input(event):
	if event.is_action_pressed("g_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
