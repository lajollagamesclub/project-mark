extends Node2D

const game_state = preload("res://game_state.tres")

func _process(delta):
	game_state.time += delta