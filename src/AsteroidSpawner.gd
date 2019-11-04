tool
extends Node2D

const game_state = preload("res://game_state.tres")

export (bool) var show_spawn_visually = false
export var safe_radius = 500.0
export var camera_view_radius = 400.0
export var player_visibility_radius = 1000.0
#export var target_enemies: int = 60
export (PackedScene) var to_spawn_pack
export (NodePath) var player_path = ""
export (Curve) var spawn_time_curve: Curve
export (float) var max_distance: float = 50000 # will stop scaling difficulty

var target_enemies: int = 60
var player_node: Node2D = null
var number_of_enemies: int = 0

func _ready():
	spawn_time_curve.bake()
	if !Engine.editor_hint:
		player_node = get_node(player_path)
	randomize()

func _process(delta):
	if Engine.editor_hint:
		if player_path != "":
			player_node = get_node(player_path)
		return
	if show_spawn_visually:
		update()
	if player_node.global_position.distance_to(Vector2()) >= safe_radius:
		while number_of_enemies < target_enemies:
			var cur_enemy = to_spawn_pack.instance()
			cur_enemy.player_node = player_node
			cur_enemy.despawn_distance = player_visibility_radius
			var theta = rand_range(0, 2*PI)
			var length = rand_range(camera_view_radius, player_visibility_radius)
			cur_enemy.global_position = player_node.global_position + \
				Vector2(cos(theta)*length, sin(theta)*length)
			cur_enemy.connect("dead", self, "enemy_died")
			add_child(cur_enemy)
			number_of_enemies += 1

	var cur_distance_fraction: float = min(1.0, float(game_state.cur_distance)/max_distance)
	target_enemies = spawn_time_curve.interpolate_baked(cur_distance_fraction)

func enemy_died():
	number_of_enemies -= 1

func _draw():
	if not show_spawn_visually:
#		pass
		return
	draw_circle(Vector2(), safe_radius, Color(0, 1, 0, 0.8))
	if player_node != null:
		draw_circle(player_node.global_position, camera_view_radius, Color(1, 0, 0, 0.4))
		draw_circle(player_node.global_position, player_visibility_radius, Color(1, 0, 0, 0.1))