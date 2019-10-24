extends KinematicBody2D

const player_state = preload("res://player_state.tres")

export var movement_speed = 700.0
export var rotational_speed = 360.0

func _process(delta):
	for asteroid in $AsteroidVisualizations.get_bodies_in_group():
		var tapped = asteroid.tap_resource(delta)
		if tapped and not is_on_wall():
			var asteroid_distance: float = global_position.distance_to(asteroid.global_position)/$AsteroidVisualizations/CollisionShape2D.shape.radius
			player_state.fuel += lerp(0.0, 10.0, asteroid_distance)*delta
	if is_on_wall():
		player_state.fuel -= 100.0*delta

func _physics_process(delta):
	var horizontal: int = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
	var vertical: int = int(Input.is_action_pressed("g_up")) - int(Input.is_action_pressed("g_down"))
#	var dash: int = int(Input.is_action_just_pressed("g_dash_right")) - int(Input.is_action_just_pressed("g_dash_left"))
	
	if Input.is_action_just_pressed("g_fire") and player_state.can_fire_bullet():
		var cur_bullet = preload("res://Bullet.tscn").instance()
		get_parent().get_node("Bullets").add_child(cur_bullet)
		cur_bullet.global_position = global_position
		cur_bullet.rotation = global_position.angle_to_point(get_global_mouse_position()) + PI
		player_state.fire_bullet()
	
	rotation += float(horizontal)*deg2rad(rotational_speed)*delta
	# Vector2 move_and_slide( Vector2 linear_velocity, Vector2 floor_normal=Vector2( 0, 0 ), bool stop_on_slope=false, int max_slides=4, float floor_max_angle=0.785398, bool infinite_inertia=true )
	move_and_slide(Vector2(0, -movement_speed).rotated(rotation), Vector2(), false, 1, 0.7, false)