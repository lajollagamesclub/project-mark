extends Button

const game_state = preload("res://game_state.tres")

func _input(event):
	if event.is_action_pressed("g_reset"):
		reload()

func _on_ReloadButton_pressed():
	reload()

func reload():
	game_state.reset_distance()
	get_tree().change_scene("res://Main.tscn")
