extends VBoxContainer

const player_state = preload("res://player_state.tres")

onready var components_list = $ComponentsList

func _ready():
	player_state.connect("components_changed", self, "_on_components_changed")
	_on_components_changed(player_state.cur_components)

func _on_components_changed(new_components):
	remove_children(components_list)
	var cur_number: int = 1
	for component_name in new_components:
		var cur_component_scene: Control = load(player_state.get_component_scene(component_name )).instance()
		components_list.add_child(cur_component_scene)
		cur_component_scene.number = cur_number
		cur_number += 1

func remove_children(parent_node: Node):
	for c in parent_node.get_children():
		c.queue_free()

func _input(event):
	if event is InputEventKey:
		if event.scancode >= KEY_1 and event.scancode <= KEY_9:
			var key_number: int = event.scancode - KEY_1 + 1
			for c in components_list.get_children():
				if c.number == key_number:
					c.on_trigger()
