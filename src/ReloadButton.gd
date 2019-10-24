extends Button

const game_state = preload("res://game_state.tres")

func _on_ReloadButton_pressed():
	game_state.time = 0.0
	get_tree().change_scene("res://Main.tscn")