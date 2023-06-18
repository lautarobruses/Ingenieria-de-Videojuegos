extends Node2D

onready var posicionSalida = get_node("Path2D/PathFollow2D")

var jingle_win = preload("res://assets/sounds/Victory/jingle_win.wav")

var player = preload("res://Player.tscn")
var naveUno = preload("res://Escenas/NaveUno.tscn")
var naveDos = preload("res://Escenas/NaveDos.tscn")
var naveTres = preload("res://Escenas/NaveTres.tscn")

var cantNaveUno = 15
var cantNaveDos = 0
var cantNaveTres = 0

var puntajeTotal = 0

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

func game_over(): #gestionar game over de victoria
	puntajeTotal -= (110 - $Player.health)
	print(puntajeTotal)
#	get_tree().quit()

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
	
func fin_fase_esbirros():
	$Player.fase = 1
	for i in self.get_children():
		if(i.has_method("salirDeLaPantalla")):
			i.salirDeLaPantalla()

func sumaPuntaje(puntaje):
	puntajeTotal+=puntaje

func _on_pause():
	$PauseMenu.show_pause()
	get_tree().paused = true

func _on_PauseMenu_play():
	$PauseMenu.hide()
	get_tree().paused = false

func _on_HealthBar_player_dead(): #DERROTA
	$Player.blow()
	$LevelUI.game_over()
	yield(get_tree().create_timer(3), "timeout")
	$PauseMenu.show_game_over()

func _on_BossHealthBar_boss_dead(): #VICTORIA
	#Puntaje
	puntajeTotal -= (110 - $Player.health)
	print(puntajeTotal)
	#Musica
	$Music.volume_db -= 25
	$Sounds.stream = jingle_win
	$Sounds.play()
	#Musica
	yield(get_tree().create_timer(3.0), "timeout")
	#Menu
	$PauseMenu.show_you_win()
	$Player.blow()
	yield(get_tree().create_timer(2.0), "timeout")
	$Music.volume_db += 25
	
	##GESTION DE ESTRELLAS

func _on_PauseMenu_retry():
	get_tree().reload_current_scene()
