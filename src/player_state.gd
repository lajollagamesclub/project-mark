extends Resource

signal fuel_changed(new_fuel)
signal health_changed(new_health)

var fuel: float = 100.0 setget set_fuel
var health: float = 100.0 setget set_health
var tree: SceneTree = null

func set_fuel(new_fuel):
	if new_fuel > 100 or new_fuel < 0:
		return
	fuel = new_fuel
	emit_signal("fuel_changed", fuel)

func set_health(new_health):
	if new_health > 100:
		return
	if new_health <= 0:
		tree.change_scene("res://GameOver.tscn")
	health = new_health
	emit_signal("health_changed", health)

func can_fire_bullet():
	return fuel > 5

func fire_bullet():
	self.fuel -= 5
