tool
extends Node2D

export (NodePath) var player_path

onready var player_node = get_node(player_path)

#func _ready():
#	set_process(!Engine.editor_hint)

func _process(delta):
	if !Engine.editor_hint:
		global_transform.origin = -get_viewport().canvas_transform.origin
	material.set_shader_param("global_transform", get_global_transform())

func _draw():
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	draw_rect(Rect2(Vector2(), Vector2(width, height)), Color(1,0,0))