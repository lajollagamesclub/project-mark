extends KinematicBody2D

const player_state = preload("res://player_state.tres")

const dashing_speed = 1500.0
const hyperspace_speed = 9000.0
const movement_speed = 600.0
const rotational_speed = 360.0

onready var target_speed: float = movement_speed
var cur_speed: float = 0.0

var is_on_wall: bool = false

func _ready():
	set_physics_process(false)
	set_process(false)
	player_state.connect("hyperspace_changed", self, "_on_hyperspace_changed")
	player_state.connect("dashing_changed", self, "_on_dashing_changed")

func _on_dashing_changed(new_dashing):
	$CollisionPolygon2D.disabled = new_dashing
	$AsteroidDestroyer.disabled = new_dashing
	if new_dashing:
		target_speed = dashing_speed
	else:
		target_speed = movement_speed

func _on_hyperspace_changed(new_hyperspace_changed):
	$CollisionPolygon2D.disabled = new_hyperspace_changed
	$AsteroidDestroyer.disabled = new_hyperspace_changed
	if new_hyperspace_changed:
		target_speed = hyperspace_speed
	else:
		target_speed = movement_speed

func _input(event):
	if event.is_action_pressed("g_start"):
		set_process(true)
		set_physics_process(true)

func _process(delta):
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
	
	$Sprite.modulate.a = 1.0 - float(player_state.dashing)*0.5


func _on_AsteroidDestroyer_bumped():
	cur_speed = 0.0
	player_state.fuel -= min(30.0, player_state.fuel - 1.0)
