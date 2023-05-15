extends CanvasLayer

onready var tween = get_node("Tween")

func _ready():
	layer = -1

func fade_in():
	layer = 99
	
	tween.interpolate_property($ColorRect, "color",
			Color("00000000"), Color("000000"), 0.25)
	tween.start()
	yield(tween, "tween_completed")

func fade_out():
	tween.interpolate_property($ColorRect, "color",
			Color("000000"), Color("00000000"), 0.25)
	tween.start()
	yield(tween, "tween_completed")
	
	layer = -1
