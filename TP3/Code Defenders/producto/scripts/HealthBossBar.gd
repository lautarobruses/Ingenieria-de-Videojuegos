extends CanvasLayer

signal level_completed

export (NodePath) var boss_node
export (int) var max_value
onready var boss = get_node(boss_node)

func _ready():
	hide()

func _process(_delta):
	$TextureProgress.value = boss.health
	if ($TextureProgress.value == $TextureProgress.min_value):
		emit_signal("level_completed")
		stop()

func start():
	$TextureProgress.value = max_value
	visible = true

func stop():
	visible = false
	queue_free()
