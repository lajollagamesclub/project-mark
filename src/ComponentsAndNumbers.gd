extends VBoxContainer

const player_state = preload("res://player_state.tres")

onready var components_list = $ComponentsList
onready var numbers_list = $NumbersList

func _ready():
	player_state.connect("components_changed", self, "_on_components_changed")
	_on_components_changed(player_state.cur_components)

func _on_components_changed(new_components):
	remove_children(components_list)
	remove_children(numbers_list)
	var cur_number: int = 1
	for component_name in new_components:
		var cur_component_scene: Control = load(player_state.get_component_scene(component_name )).instance()
		components_list.add_child(cur_component_scene)
		var cur_number_label: ComponentNumberLabel = preload("res://ComponentNumberLabel.tscn").instance()
		cur_number_label.number = cur_number
		numbers_list.add_child(cur_number_label)

func remove_children(parent_node: Node):
	for c in parent_node.get_children():
		c.queue_free()
