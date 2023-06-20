extends TipoNaveDisparo

onready var parte = preload("res://Escenas/PremioNaveTres.tscn")
# setear vidas de la nave
# setear las conexiones
# var b = "text"
var damage = 10

func _ready():
	vidas = 2
	play("normal")


func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var parte1 = parte.instance()
		get_parent().add_child(parte1)
		parte1.init(position,3)
		queue_free()
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
