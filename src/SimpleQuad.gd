extends Node2D

class_name SimpleQuad

func _draw():
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	var size_vect: Vector2 = Vector2(width, height)
	draw_rect(Rect2(-size_vect/2, size_vect), Color(1,0,0))
