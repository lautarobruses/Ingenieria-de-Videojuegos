extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.visible = true
	$AnimationPlayer.play("Present Song")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
