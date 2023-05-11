extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var proyectil = preload("res://Escenas/misilJugador.tscn")
var player = preload("res://Escenas/Jugador.tscn")
var naveUno = preload("res://Escenas/NaveUno.tscn")
var naveDos = preload("res://Escenas/NaveDos.tscn")
var naveTres = preload("res://Escenas/NaveTres.tscn")

var naveMadre = preload("res://Escenas/Boss.tscn")

onready var posicionSalida = get_node("Path2D/PathFollow2D")
var cantNaveUno = 3
var cantNaveDos = 0
var cantNaveTres = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$finFaseEsbirros.start()
	for i in cantNaveTres:
		var nuevoEnemigo = naveTres.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveDos:
		var nuevoEnemigo = naveDos.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveUno:
		var nuevoEnemigo = naveUno.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	
pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if Input.is_action_just_pressed("shoot"):
#		var midisparo = proyectil.instance()
#		midisparo.position = $Jugador.position
#		midisparo.start($Jugador.rotation_degrees)
#		add_child(midisparo)
		

func posicionRandom():
	randomize()
	posicionSalida.offset = randi()
	return posicionSalida.position	




func _on_finFaseEsbirros_timeout():
	for i in self.get_children():
		if(i.has_method("salirDeLaPantalla")):
			i.salirDeLaPantalla()
	$tiempoDeRetirada.start()
	pass # Replace with function body.


func _on_tiempoDeRetirada_timeout():
	var naveM = naveMadre.instance()
	naveM.position = Vector2(1700,360)
	add_child(naveM)
	pass # Replace with function body.
