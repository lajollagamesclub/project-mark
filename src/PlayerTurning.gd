extends KinematicBody2D

const player_state = preload("res://player_state.tres")

const dash_time = 0.5
const dash_cooldown_time = 3.0
const dash_speed = 1500.0
const movement_speed = 600.0
const rotational_speed = 360.0


var dashing: bool = false
onready var target_speed: float = movement_speed
var cur_speed: float = 0.0
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
			$AsteroidDestroyer.disabled = false
			cur_dash_time = 0.0
			cur_dash_cooldown_time = 0.0
			target_speed = movement_speed
			dashing = false

#	print(cur_dash_cooldown_time >= dash_cooldown_time)
	if Input.is_action_just_pressed("g_dash") and not dashing and cur_dash_cooldown_time >= dash_cooldown_time:
		$CollisionPolygon2D.disabled = true
		$AsteroidDestroyer.disabled = true
		target_speed = dash_speed
		$Sprite.modulate.a = 0.5
		dashing = true

func _physics_process(delta):
	var horizontal: int = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
# warning-ignore:unused_variable
	var vertical: int = int(Input.is_action_pressed("g_up")) - int(Input.is_action_pressed("g_down"))
#	var horizontal_fire: int = int(Input.is_action_just_pressed("g_fire_right")) - int(Input.is_action_just_pressed("g_fire_left"))
#	var vertical_fire: int = int(Input.is_action_just_pressed("g_fire_down")) - int(Input.is_action_just_pressed("g_fire_up"))
#	var dash: int = int(Input.is_action_just_pressed("g_dash_right")) - int(Input.is_action_just_pressed("g_dash_left"))
	
	if player_state.can_fire_bullet() and Input.is_action_just_pressed("g_fire"):

		var width = ProjectSettings.get_setting("display/window/size/width")
		var height = ProjectSettings.get_setting("display/window/size/height")
		var size_vect: Vector2 = Vector2(width, height)
		
		var rotation_vector: Vector2 = (get_viewport().get_mouse_position() - size_vect/2).normalized()
		var rotation_input: float = rotation_vector.angle()
		rotation_input = rotation_input
		
		var input_vector = Vector2(1, 0).rotated(rotation_input)

		$BulletSpawner.spawn_bullet(rotation_input)
		$FireStreamPlayer.play()
		player_state.fire_bullet()
	
	rotation += float(horizontal)*deg2rad(rotational_speed)*delta
	#move_and_slide(Vector2(0, -cur_speed).rotated(rotation), Vector2(), false, 1, 0.7, false)
	cur_speed = lerp(cur_speed, target_speed, 0.1)
	var movement_vector: Vector2 = Vector2(0, -cur_speed).rotated(rotation)*delta
	is_on_wall = test_move(global_transform, movement_vector, false)
	if not is_on_wall:
#		get_node("../World").global_position -= movement_vector
		player_state.move(-movement_vector)


func _on_AsteroidDestroyer_bumped():
	cur_speed = 0.0
	player_state.fuel -= min(30.0, player_state.fuel - 1.0)
