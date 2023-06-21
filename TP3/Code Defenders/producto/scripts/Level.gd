extends Node2D

onready var posicionSalida = get_node("Path2D/PathFollow2D")
onready var ui = get_node("LevelUI")

var jingle_win = preload("res://assets/sounds/Victory/jingle_win.wav")

var player = preload("res://Player.tscn")
var naveUno = preload("res://Escenas/NaveUno.tscn")
var naveDos = preload("res://Escenas/NaveDos.tscn")
var naveTres = preload("res://Escenas/NaveTres.tscn")
var naveCinco = preload("res://Escenas/NaveCinco.tscn")
var naveSeis = preload("res://Escenas/NaveSeis.tscn")

var nivel
var cantNaveUno
var cantNaveDos
var cantNaveTres
var cantNaveCinco
var cantNaveSeis
var winning = false
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

func fase_esbirros():
	$Player.fase = 0
	for i in cantNaveTres:
		yield(get_tree().create_timer(1), "timeout")
		var nuevoEnemigo = naveTres.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveDos:
		yield(get_tree().create_timer(1), "timeout")
		var nuevoEnemigo = naveDos.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveUno:
		yield(get_tree().create_timer(1), "timeout")
		var nuevoEnemigo = naveUno.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveCinco:
		yield(get_tree().create_timer(1), "timeout")
		var nuevoEnemigo = naveCinco.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)
	for i in cantNaveSeis:
		yield(get_tree().create_timer(1), "timeout")
		var nuevoEnemigo = naveSeis.instance()
		nuevoEnemigo.position = posicionRandom()
		add_child(nuevoEnemigo)

func fin_fase_esbirros():
	$Player.fase = 1
	for i in self.get_children():
		if(i.has_method("salirDeLaPantalla")):
			i.salirDeLaPantalla()
	get_tree().call_group("Componentes", "queue_free")

func sumaPuntaje(puntaje):
	puntajeTotal+=puntaje
	ui.setScore(puntajeTotal)

func _on_pause():
	$PauseMenu.show_pause(nivel)
	$Player.hide()
	$Player.freeze()
	get_tree().paused = true

func _on_PauseMenu_play():
	$PauseMenu.hide()
	$Player.show()
	$Player.unfreeze()
	get_tree().paused = false

func _on_HealthBar_player_dead(): #DERROTA
	if (winning == false):
		$Player.blow()
		$LevelUI.game_over()
		if(nivel!=3):
			$BossHealthBar.hide()
		yield(get_tree().create_timer(3), "timeout")
		#Seteo el puntaje
		$PauseMenu.show_game_over()

func _on_BossHealthBar_boss_dead(): #VICTORIA
	winning = true
	$Player.freeze()
	#Puntaje
	puntajeTotal -= (1100 - $Player.health * 10)
	guardaPuntaje()
	Persistencia.save_game()
	#Musica
	$Music.volume_db -= 25
	$Sounds.stream = jingle_win
	$Sounds.play()
	#Musica
	yield(get_tree().create_timer(6.0), "timeout")
	#Menu
	$PauseMenu.show_you_win(nivel,puntajeTotal)
	$Player.blow()
	yield(get_tree().create_timer(2.0), "timeout")
	$Music.volume_db += 25

func _on_PauseMenu_retry():
	get_tree().reload_current_scene()
	
func setNivel(n):
	nivel = n

func guardaPuntaje():
	match nivel:
		1:
			Persistencia.setNivelUno(puntajeTotal)
		2:
			Persistencia.setNivelDos(puntajeTotal)
		3:
			Persistencia.setNivelTres(puntajeTotal)
		4:
			Persistencia.setNivelCuatro(puntajeTotal)
			
func setEnemigos():
	match nivel:
		1:
			cantNaveUno = 5
			cantNaveSeis = 2
			cantNaveTres = 2
			cantNaveCinco = 0
			cantNaveDos = 0
		2:
			cantNaveCinco = 2
			cantNaveUno = 4
			cantNaveDos = 4
			cantNaveTres = 0
			cantNaveSeis = 0
