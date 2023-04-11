extends ParallaxBackground

export (float) var scroll_speed = 10.0

func _physics_process(delta):
	var offset = get_scroll_base_offset()
	offset.x += scroll_speed * delta
	set_scroll_base_offset(offset)
