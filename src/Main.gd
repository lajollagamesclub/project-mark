extends Node2D

const player_state = preload("res://player_state.tres")

const distance_filename = "user://score.txt"

func _ready():
	player_state.tree = get_tree()
	player_state.cur_position = Vector2(0.0, 0.0)
	player_state.health = 100.0
	
	
	var distance_file = File.new()
	if distance_file.file_exists(distance_filename):
		distance_file.open(distance_filename, File.READ)
		player_state.max_distance = int(distance_file.get_as_text())
	distance_file.close()

func _input(event):
	if event.is_action_pressed("g_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func _on_Main_tree_exiting():
	save_score()

func save_score():
	var distance_file = File.new()
	distance_file.open(distance_filename, File.WRITE)
	distance_file.store_string(str(player_state.max_distance))
	distance_file.close()

func _on_SaveScoreButton_pressed():
	save_score()
