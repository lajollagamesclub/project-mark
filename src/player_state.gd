extends Resource

signal fuel_changed(new_fuel)

var fuel: float = 100 setget set_fuel

func set_fuel(new_fuel):
	if new_fuel > 100 or new_fuel < 0:
		return
	fuel = new_fuel
	emit_signal("fuel_changed", fuel)

func can_fire_bullet():
	return fuel > 5

func fire_bullet():
	self.fuel -= 5
