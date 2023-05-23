extends Node2D

var player = preload("res://Player.tscn")
var naveUno = preload("res://Escenas/NaveUno.tscn")
var naveDos = preload("res://Escenas/NaveDos.tscn")
var naveTres = preload("res://Escenas/NaveTres.tscn")

var cantNaveUno = 10
var cantNaveDos = 0
var cantNaveTres = 0

onready var posicionSalida = get_node("Path2D/PathFollow2D")

func posicionRandom():
	randomize()
	posicionSalida.offset = randi()
	return posicionSalida.position	

func set_player():
	$Player.start()
	$HealthBar.start()

func set_music(song):
	$Music.stream = song
	$Music.play()

func game_over():
	get_tree().quit()
	pass

func fase_esbirros():
	$Player.fase = 0
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
	$Player.fase = 1
	for i in self.get_children():
		if(i.has_method("salirDeLaPantalla")):
			i.salirDeLaPantalla()
	pass

func by_defeating_boss():
	yield(get_tree().create_timer(1), "timeout")
	get_tree().quit()
	pass 


func _on_pause():
	$PauseMenu.show()
	get_tree().paused = true

func _on_PauseMenu_play():
	$PauseMenu.hide()
	get_tree().paused = false
