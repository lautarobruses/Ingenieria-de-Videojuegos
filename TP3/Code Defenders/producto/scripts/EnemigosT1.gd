extends TipoNaveSimple

onready var parte = preload("res://Escenas/PremioNaveUno.tscn")

func _ready():
	velocidad = 3
	vidas = 1
	$turbo.play("fuego")
	play("normal")

func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var parte1 = parte.instance()
		get_parent().add_child(parte1)
		parte1.init(position,1)
		queue_free()
	pass # Replace with function body.



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
