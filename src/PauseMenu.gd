extends PanelContainer

func _input(event):
	if event.is_action_pressed("g_pause"):
		visible = !visible
		get_tree().paused = visible
