extends KinematicBody2D

export var movement_speed = 700.0
export var rotational_speed = 360.0

func _physics_process(delta):
	var horizontal: int = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
	var vertical: int = int(Input.is_action_pressed("g_up")) - int(Input.is_action_pressed("g_down"))
#	var dash: int = int(Input.is_action_just_pressed("g_dash_right")) - int(Input.is_action_just_pressed("g_dash_left"))
	
	rotation += float(horizontal)*deg2rad(rotational_speed)*delta
	
	move_and_collide(Vector2(0, -movement_speed).rotated(rotation)*delta, false)