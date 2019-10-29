extends Node2D

var is_high_performance = true setget set_is_high_performance

var fps_measurements: int = 0
var cur_fps_average: float = 0.0
var cur_fps_measuring_counter: float = 0

func _ready():
	self.is_high_performance = true
	set_process(false)

func _process(delta):
	cur_fps_measuring_counter += delta
	fps_measurements += 1
	cur_fps_average += Engine.get_frames_per_second()
	print(Engine.get_frames_per_second(), "	", cur_fps_average, "	", fps_measurements)
#	print(cur_fps_average/float(fps_measurements))
	if cur_fps_measuring_counter >= 1.0:
		
		if cur_fps_average/float(fps_measurements) <= 40.0:
			self.is_high_performance = false
		else:
			self.is_high_performance = true
		set_process(false)

func set_is_high_performance(new_is_high_performance):
	is_high_performance = new_is_high_performance
	$HighPerformanceStars.visible = is_high_performance
	$LowPerformanceStars.visible = !is_high_performance


func _on_StartMeasuringTimer_timeout():
	set_process(true)
