extends Area2D

signal levantaSimbolo

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("rebote")
	self.connect("body_entered",self,"bodyEntered")
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

func bodyEntered(body):
	emit_signal("levantaSimbolo")
	queue_free()
	pass # Replace with function body.
