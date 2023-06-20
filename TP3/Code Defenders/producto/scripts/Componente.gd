extends Area2D

var puntajeDeLevantar = 300
var timer
signal levantaSimbolo

func _ready():
	$AnimationPlayer.play("rebote")
	yield(get_tree().create_timer(4.0), "timeout")
	salida()

func init(posicion_nave, tipo):
	position = posicion_nave
	match tipo:
		1:
			$AnimatedSprite.play("1")
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveUno_levantaSimbolo")
			continue
		2:
			$AnimatedSprite.play("2")
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveDos_levantaSimbolo")
			continue
		3:
			$AnimatedSprite.play("3")
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveTres_levantaSimbolo")
			continue
		4:
			$AnimatedSprite.play("4")
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveCuatro_levantaSimbolo")
			continue
		5:
			$AnimatedSprite.play("5")
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveCinco_levantaSimbolo")
			continue
		6:
			$AnimatedSprite.play("6")
			self.connect("levantaSimbolo",get_parent().get_node("Barra"),"_on_ParteNaveSeis_levantaSimbolo")
			continue

func salida():
	$AnimationPlayer.play("salida")
	yield(get_tree().create_timer(1), "timeout")
	queue_free()

func _on_Componente_body_entered(body):
	emit_signal("levantaSimbolo")
	get_parent().sumaPuntaje(puntajeDeLevantar)
	queue_free()
