extends Node2D

func _ready():
	if OS.get_name() == "Android":
		$HighPerformanceStars.visible = false
		$LowPerformanceStars.visible = true
	else:
		$HighPerformanceStars.visible = true
		$LowPerformanceStars.visible = false