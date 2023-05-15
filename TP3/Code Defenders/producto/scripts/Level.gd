extends Node2D

var player = preload("res://Player.tscn")
var boss1 = preload("res://Boss1.tscn")
var proyectil = preload("res://Escenas/misilJugador.tscn")
var naveUno = preload("res://Escenas/NaveUno.tscn")
var naveDos = preload("res://Escenas/NaveDos.tscn")
var naveTres = preload("res://Escenas/NaveTres.tscn")

var cantNaveUno = 10
var cantNaveDos = 0
var cantNaveTres = 0
onready var posicionSalida = get_node("Path2D/PathFollow2D")


func _ready():
	randomize()
	start_level()


func posicionRandom():
	randomize()
	posicionSalida.offset = randi()
	return posicionSalida.position	


func start_level():
	set_player()
	set_boss()
	#creaEnemigos()
	$AnimationPlayer.play("main")
	pass

func set_player():
	$Player.start()

func set_boss():
	$Boss1.start()

func game_over():
	get_tree().quit()
	pass

func fase_esbirros():
	for i in cantNaveTres:
		var nuevoEnemigo = naveTres.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveDos:
		var nuevoEnemigo = naveDos.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveUno:
		yield(get_tree().create_timer(1), "timeout")
		var nuevoEnemigo = naveUno.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	pass
	
func fin_fase_esbirros():
	for i in self.get_children():
		if(i.has_method("salirDeLaPantalla")):
			i.salirDeLaPantalla()
	pass

func by_defeating_boss():
	get_tree().quit()
	pass 
	
func _on_Boss_broken_shield():
	$BossHealthBar.start()
