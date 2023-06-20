extends TipoNaveSimple

onready var componente = preload("res://Componente.tscn")

func _ready():
	velocidad = 5
	vidas = 1
	$turbo.play("fuego")
	$nave.play("normal")

func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var new_componente = componente.instance()
		get_parent().add_child(new_componente)
		new_componente.init(position, 1)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
