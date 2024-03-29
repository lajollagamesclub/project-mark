extends Node2D

const player_state = preload("res://player_state.tres")

export (NodePath) var player_path: NodePath = ""
export (PackedScene) var enemy_pack
export (Curve) var spawn_time_curve: Curve
export (float) var max_distance: float = 50000 # will stop scaling difficulty

var cur_time: float = 0.0

onready var cur_max_time: float = spawn_time_curve.max_value
onready var player_node: Node2D = get_node(player_path)

func _ready():
	randomize()

func _process(delta):
	cur_time += delta
	if cur_time > cur_max_time and player_state.cur_distance >= 500.0:
		cur_time = 0.0
		spawn_enemy()
		var cur_distance_fraction: float = min(1.0, float(player_state.cur_distance)/max_distance)
		cur_max_time = spawn_time_curve.interpolate(cur_distance_fraction)
#		print(cur_max_time)

func spawn_enemy():
	var cur_enemy = enemy_pack.instance()
	cur_enemy.player_node = player_node
	var theta = rand_range(0, 2*PI)
	cur_enemy.global_position = player_node.global_position + Vector2(
		cos(theta)*3000,
		sin(theta)*3000
	)
	get_node("/root/Main/World/Enemies").add_child(cur_enemy)
