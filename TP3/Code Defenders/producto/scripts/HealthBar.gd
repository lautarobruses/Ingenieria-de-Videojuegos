extends CanvasLayer

signal dead

export (NodePath) var player_node
export (int) var max_value
onready var player = get_node(player_node)

func _ready():
#	hide()
	pass

func _process(_delta):
	$TextureProgress.value = player.health
	if ($TextureProgress.value == $TextureProgress.min_value):
		emit_signal("dead")
		stop()

func start():
	$TextureProgress.value = max_value
	visible = true

func stop():
	visible = false
	queue_free()
