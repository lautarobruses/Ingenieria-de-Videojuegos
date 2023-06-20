extends TipoNaveDisparo

onready var componente = preload("res://Componente.tscn")

func _ready():
	vidas = 6
	velocidad = 2

func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var new_componente = componente.instance()
		get_parent().add_child(new_componente)
		new_componente.init(position, 6)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
