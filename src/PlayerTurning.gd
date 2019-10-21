extends KinematicBody2D

export var move_acceleration = 50.0
export var switching_acceleration = 90.0
export var move_decelleration = 80.0
export var maximum_velocity = 1200.0

export var rotational_acceleration = 1200.0
export var rotational_switching_acceleration = 5000.0
export var rotational_decelleration = 1500.0
export var maximum_rotational_velocity = 900.0

var acceleration: Vector2 = Vector2()
var velocity: Vector2 = Vector2()

var rotational_accel: float = 0.0
var rotational_vel: float = 0.0

func _physics_process(delta):
	var horizontal: int = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
	var vertical: int = int(Input.is_action_pressed("g_down")) - int(Input.is_action_pressed("g_up"))

	
	if abs(velocity.x) < move_decelleration*delta:
		velocity.x = 0.0
	if abs(velocity.y) < move_decelleration*delta:
		velocity.y = 0.0
	if abs(rotational_vel) < rotational_decelleration*delta:
		rotational_vel = 0.0
	acceleration.x = calculate_acceleration(horizontal, delta, velocity.x, move_decelleration, move_acceleration, switching_acceleration)
	rotational_accel = calculate_acceleration(horizontal, delta, rotational_vel, rotational_decelleration, rotational_acceleration, rotational_switching_acceleration)
	print(rotational_accel)
	acceleration.y = calculate_acceleration(vertical, delta, velocity.y, move_decelleration, move_acceleration, switching_acceleration)

	rotational_vel += rotational_accel*delta
	velocity += acceleration.rotated(rotation)*delta
	
	velocity.x = clamp(velocity.x, -maximum_velocity, maximum_velocity)
	velocity.y = clamp(velocity.y, -maximum_velocity, maximum_velocity)
	rotational_vel = clamp(rotational_vel, -maximum_rotational_velocity, maximum_rotational_velocity)
	
	velocity = move_and_slide(velocity)
	rotation += deg2rad(rotational_vel)*delta
#	if get_nu

func calculate_acceleration(input: int, delta: float, velocity: float, decelleration: float, acceleration: float, switching_acceleration: float) -> float:
	if input == 0:
		return -sign(velocity)*decelleration
	else:
		if sign(input) != int(sign(velocity)):
			return float(input)*switching_acceleration
		else:
			return float(input)*acceleration