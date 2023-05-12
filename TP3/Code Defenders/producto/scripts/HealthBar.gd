extends CanvasLayer

signal dead

export (NodePath) var player_node
export (int) var max_value
var player = preload("res://Player.tscn")

func _ready():
#	hide()
	pass

func _process(_delta):
#	$TextureProgress.value = player.health
	if ($TextureProgress.value == $TextureProgress.min_value):
		emit_signal("dead")
		stop()

func start():
	$TextureProgress.value = max_value
	visible = true

func stop():
	visible = false
	queue_free()
