tool
extends Node2D

const player_state = preload("res://player_state.tres")

export var relative_motion: float = 1.0 setget set_relative_motion
export var parallax_scale: float = 1.0
export var offset: Vector2 = Vector2() setget set_offset

func _ready():
	set_process(!Engine.editor_hint)

func _process(_delta):
#	if !Engine.editor_hint:
#		global_transform.origin = -get_viewport().canvas_transform.origin
	
	global_transform.origin = Vector2()
	var out_transform: Transform2D = Transform2D(0.0, player_state.cur_position)
	out_transform.origin *= -1
	out_transform.origin *= parallax_scale
	material.set_shader_param("global_transform", out_transform)

func _draw():
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	var size_vect: Vector2 = Vector2(width, height)
	draw_rect(Rect2(-size_vect/2, size_vect), Color(1,0,0))

func set_relative_motion(new_relative_motion):
	relative_motion = new_relative_motion
	material.set_shader_param("relative_motion", relative_motion)

func set_offset(new_offset):
	offset = new_offset
	material.set_shader_param("offset", offset)
