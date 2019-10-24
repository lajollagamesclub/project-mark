extends Resource

signal fuel_changed(new_fuel)

var fuel: float = 100 setget set_fuel

func set_fuel(new_fuel):
	if new_fuel > 100:
		return
	fuel = new_fuel
	emit_signal("fuel_changed", fuel)

func fire_bullet():
	self.fuel -= 5