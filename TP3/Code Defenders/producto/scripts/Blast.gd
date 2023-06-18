extends Node2D

func _ready():
	$AnimatedSprite.play("default")

func _process(delta):
	if $AnimatedSprite.is_playing():
		return
		
		queue_free()
