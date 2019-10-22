extends RigidBody2D

export var forward_force = 2000
export var frictional_force = 1300
export var turning_torque = 500.0


func _physics_process(delta):
	var horizontal: int = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
	var vertical: int = int(Input.is_action_pressed("g_up")) - int(Input.is_action_pressed("g_down"))
	
	applied_force = Vector2()
	
	# Move forward constantly
	applied_force += Vector2(0, -forward_force).rotated(rotation)
	
	# Dampeners
	var dampening_force = frictional_force*(-linear_velocity).normalized()
	var dampening_facing = abs(min(0, dampening_force.normalized().dot(applied_force.normalized())))*-1 + 1
#	print(dampening_facing)
	applied_force += dampening_force*dampening_facing
	print(applied_force)
	
	# Turn from input
	angular_velocity = horizontal*deg2rad(turning_torque)