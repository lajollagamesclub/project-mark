extends Sprite

var rot_velocity: float = 0.0
var move_velocity: float = 0.0

func _ready():
	randomize()
	rot_velocity = rand_range(-PI, PI)
	move_velocity = rand_range(30.0, 80.0)

func _process(delta):
	rotation += rot_velocity*delta
	position += (position).normalized()*move_velocity*delta
