extends KinematicBody2D

const player_state = preload("res://player_state.tres")
const game_state = preload("res://game_state.tres")

const dash_time = 0.5
const dash_cooldown_time = 3.0
const dash_speed = 1500.0
const movement_speed = 600.0
const rotational_speed = 360.0


var dashing: bool = false
onready var cur_speed: float = movement_speed
var cur_dash_time: float = 0.0
var cur_dash_cooldown_time: float = 0.0

var is_on_wall: bool = false

func _ready():
	set_physics_process(false)
	set_process(false)

func _input(event):
	if event.is_action_pressed("g_start"):
		set_process(true)
		set_physics_process(true)

func _process(delta):
	game_state.cur_distance = get_node("../World").global_position.distance_to(Vector2())
	cur_dash_cooldown_time += delta
	for asteroid in $AsteroidVisualizations.get_bodies_in_group():
		var tapped = asteroid.tap_resource(delta)
		if tapped and not is_on_wall():
			var asteroid_distance: float = global_position.distance_to(asteroid.global_position)/$AsteroidVisualizations/CollisionShape2D.shape.radius

			if player_state.fuel >= 99.9:
				player_state.health += lerp(0.0, 3.0, asteroid_distance)*delta
			else:
				player_state.fuel += lerp(0.0, 10.0, asteroid_distance)*delta
	if is_on_wall:
		player_state.fuel -= 100.0*delta
		
	$Sprite.modulate.a = lerp(0.2, 1.0, min(cur_dash_cooldown_time,dash_cooldown_time)/dash_cooldown_time)

	if dashing:
		cur_dash_cooldown_time = 0.0
		cur_dash_time += delta
		
		if cur_dash_time > dash_time:
			$CollisionPolygon2D.disabled = false
			cur_dash_time = 0.0
			cur_dash_cooldown_time = 0.0
			cur_speed = movement_speed
			dashing = false

#	print(cur_dash_cooldown_time >= dash_cooldown_time)
	if Input.is_action_just_pressed("g_dash") and not dashing and cur_dash_cooldown_time >= dash_cooldown_time:
		$CollisionPolygon2D.disabled = true
		cur_speed = dash_speed
		$Sprite.modulate.a = 0.5
		dashing = true

func _physics_process(delta):
	var horizontal: int = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
# warning-ignore:unused_variable
	var vertical: int = int(Input.is_action_pressed("g_up")) - int(Input.is_action_pressed("g_down"))
	var horizontal_fire: int = int(Input.is_action_just_pressed("g_fire_right")) - int(Input.is_action_just_pressed("g_fire_left"))
	var vertical_fire: int = int(Input.is_action_just_pressed("g_fire_down")) - int(Input.is_action_just_pressed("g_fire_up"))
#	var dash: int = int(Input.is_action_just_pressed("g_dash_right")) - int(Input.is_action_just_pressed("g_dash_left"))
	
	if player_state.can_fire_bullet() and (abs(horizontal_fire) > 0 or abs(vertical_fire) > 0):

		var rotation_vector: Vector2 = Vector2(horizontal_fire, vertical_fire)
		var rotation_input: float = rotation_vector.angle()
		rotation_input = rotation_input
		
		var input_vector = Vector2(1, 0).rotated(rotation_input)

		rotation_input = $AutoAim.get_suggestion(input_vector, 45.0)
		$BulletSpawner.spawn_bullet(rotation_input)
		$FireStreamPlayer.play()
		player_state.fire_bullet()
	
	rotation += float(horizontal)*deg2rad(rotational_speed)*delta
	#move_and_slide(Vector2(0, -cur_speed).rotated(rotation), Vector2(), false, 1, 0.7, false)
	var movement_vector: Vector2 = Vector2(0, -cur_speed).rotated(rotation)*delta
	is_on_wall = test_move(global_transform, movement_vector, false)
	if not is_on_wall:
		get_node("../World").global_position -= movement_vector
