extends CenterContainer

class_name ComponentNumberLabel

var number: int = 0 setget set_number

func set_number(new_number):
	number = new_number
	if has_node("Label"):
		$Label.text = str(number)
