extends Node2D

export (PackedScene) var bullet_pack

func spawn_bullet(rotation: float):
    var cur_bullet = bullet_pack.instance()
    get_node("/root/Main/Bullets").add_child(cur_bullet)
    cur_bullet.global_position = global_position
    cur_bullet.rotation = rotation
