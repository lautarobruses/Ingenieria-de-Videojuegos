extends TipoNaveDisparo


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var parte = preload("res://Escenas/PremioNaveSeis.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	vidas = 6
	velocidad = 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var parte1 = parte.instance()
		get_parent().add_child(parte1)
		parte1.init(position,6)
		queue_free()
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
