extends Area2D

var puntajeDeLevantar = 300
var timer
signal levantaSimbolo

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("rebote")
	self.connect("body_entered",self,"bodyEntered")
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 4.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", self, "_on_timer_timeout")
	pass # Replace with function body.

func init(posicion_nave,tipo):
	position = posicion_nave
	match tipo:
		1:
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveUno_levantaSimbolo")
			continue
		2:
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveDos_levantaSimbolo")
			continue
		3:
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveTres_levantaSimbolo")
			continue
		4:
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveCuatro_levantaSimbolo")
			continue
		5:
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveCinco_levantaSimbolo")
			continue
		6:
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveSeis_levantaSimbolo")
			continue

func bodyEntered(_body):
	emit_signal("levantaSimbolo")
	get_parent().sumaPuntaje(puntajeDeLevantar)
	queue_free()

func _on_timer_timeout():
	$AnimationPlayer.play("salida")
	yield(get_tree().create_timer(1), "timeout")
	queue_free()

#func _on_AnimationPlayer_animation_finished(anim_name):
#	if (anim_name == "salida"):
#		queue_free()
