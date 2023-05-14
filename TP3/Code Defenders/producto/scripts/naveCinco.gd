extends TipoNaveDisparo


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var parte = preload("res://Escenas/PremioNaveCinco.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	vidas = 1
	pass # Replace with function body.


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
		var parte1 = parte.instance()
		get_parent().add_child(parte1)
		parte1.init(position)
		queue_free()
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
