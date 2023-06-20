extends TipoNaveDisparo

onready var componente = preload("res://Componente.tscn")

func _ready():
	vidas = 1

func shoot():
	if moviendo == 0 :
			var projectile = disparo.instance()
			var projectile2 = disparo.instance()
			var projectile3 = disparo.instance()
			projectile.start($Position2D.global_position,rotation + PI)
			projectile2.start($Position2D.global_position,rotation + PI - PI/8)
			projectile3.start($Position2D.global_position,rotation + PI + PI/8)
			get_parent().add_child(projectile)
			get_parent().add_child(projectile2)
			get_parent().add_child(projectile3)
			yield($esperaDisparo, "timeout")

func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var new_componente = componente.instance()
		get_parent().add_child(new_componente)
		new_componente.init(position, 5)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
