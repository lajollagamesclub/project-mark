extends Resource

# warning-ignore:unused_class_variable
var distance: int = 0 setget set_distance

func set_distance(new_distance):
	if new_distance > distance:
		distance = int(round(new_distance))

func reset_distance():
	distance = 0
