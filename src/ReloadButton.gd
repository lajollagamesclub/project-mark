extends Button

const player_state = preload("res://player_state.tres")

func _input(event):
	if event.is_action_pressed("g_reset"):
		reload()

func _on_ReloadButton_pressed():
	reload()

func reload():
	player_state.reset_distance()
	get_tree().change_scene("res://Main.tscn")
