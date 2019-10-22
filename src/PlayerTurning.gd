extends RigidBody2D

export var forward_force = 2000
export var frictional_force = 10000
export var turning_torque = 400.0
export var dash_impulse = 5000.0


func _physics_process(delta):
	var horizontal: int = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
	var vertical: int = int(Input.is_action_pressed("g_up")) - int(Input.is_action_pressed("g_down"))
	var dash: int = int(Input.is_action_just_pressed("g_dash_right")) - int(Input.is_action_just_pressed("g_dash_left"))
	applied_force = Vector2()
	
	# Move forward constantly
	applied_force += Vector2(0, -forward_force).rotated(rotation)
	
	# Dampeners
	var dampening_force = frictional_force*(-linear_velocity).normalized()
	# Remove dampening in direction of travel
	var dampening_facing = abs(min(0, dampening_force.normalized().dot(applied_force.normalized())))*-1 + 1
	applied_force += dampening_force*dampening_facing
	
	# Turn from input
	angular_velocity = horizontal*deg2rad(turning_torque)
	
	# Apply dashing
	if dash != 0:
		apply_central_impulse(Vector2(float(dash)*dash_impulse, 0).rotated(rotation))