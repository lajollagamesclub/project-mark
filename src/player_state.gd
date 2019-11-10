extends Resource

signal fuel_changed(new_fuel)
signal health_changed(new_health)
signal moved(move_vector)

# warning-ignore:unused_class_variable
var max_distance: int = 0 
var cur_distance: int = 0 setget ,get_cur_distance
var cur_position: Vector2 = Vector2()
var fuel: float = 100.0 setget set_fuel
var health: float = 100.0 setget set_health
var tree: SceneTree = null

func get_cur_distance() -> int:
	return int(cur_position.length())

func move(move_vector: Vector2):
	cur_position += move_vector
	emit_signal("moved", move_vector)
	if self.cur_distance > max_distance:
		max_distance = int(round(self.cur_distance))

func set_fuel(new_fuel):
	if new_fuel > 100 or new_fuel < 0:
		return
	fuel = new_fuel
	emit_signal("fuel_changed", fuel)

func set_health(new_health):
	if new_health > 100:
		return
	if new_health <= 0:
		tree.change_scene("res://Main.tscn")
		health = 100
		fuel = 100
		emit_signal("health_changed", health)
		return
	health = new_health
	emit_signal("health_changed", health)

func can_fire_bullet():
	return fuel > 5

func fire_bullet():
	self.fuel -= 5
