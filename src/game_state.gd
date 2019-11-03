extends Resource

# warning-ignore:unused_class_variable
var max_distance: int = 0 
var cur_distance: int = 0 setget set_distance

func set_distance(new_distance):
	cur_distance = new_distance
	if new_distance > max_distance:
		max_distance = int(round(new_distance))

func reset_distance():
	cur_distance = 0