extends CanvasLayer

signal dead

export (NodePath) var target_node
export (int) var max_value
onready var target = get_node(target_node)

export (bool) var isEnable

func _ready():
	pass

func _process(_delta):
	if (isEnable):
		$TextureProgress.value = target.health
		if ($TextureProgress.value <= $TextureProgress.min_value):
			stop()

func start():
	visible = true
	$TextureProgress.max_value = max_value
	$AnimationPlayer.play("enable")
	if (!isEnable):
		isEnable = true

func stop():
	isEnable = false
	$AnimationPlayer.play("disable")
	emit_signal("dead")
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()

func show():
	$AnimationPlayer.play("enable")
	
func hide():
	$AnimationPlayer.play("disable")
