extends Node2D

signal play
signal retry

onready var estrella1 = $WindowContainer/PStar1
onready var estrella2 = $WindowContainer/PStar2
onready var estrella3 = $WindowContainer/PStar3

var estrellasN1 = [10000, 7500, 4000]
var estrellasN2 = [6000, 4000, 3000]
var estrellasN3 = [1120, 700, 400]
var estrellasN4 = [0, 0, 0]

func _ready():
	pass # Replace with function body.

func show_pause(nivel):
	var puntaje
	
	Persistencia.load_game()
	$WindowContainer/Title.text = tr("PAUSE_MENU_PAUSE")
	$WindowContainer/PlayButton.show()
	$WindowContainer/RetryButton.hide()
	if nivel == 1: #NivelUno
		puntaje = Persistencia.getPuntajeNivelUno()
		if(puntaje >= estrellasN1[0]):
			tres_estrellas_dorada()
		elif(puntaje >= estrellasN1[1]):
			dos_estrellas_dorada()
		elif(puntaje >= estrellasN1[2]):
			una_estrellas_dorada()
		else:
			cero_estrellas()
	elif nivel == 2: #NivelDos
		puntaje = Persistencia.getPuntajeNivelDos()
		if(puntaje >= estrellasN2[0]):
			tres_estrellas_dorada()
		elif(puntaje >= estrellasN2[1]):
			dos_estrellas_dorada()
		elif(puntaje >= estrellasN2[2]):
			una_estrellas_dorada()
		else:
			cero_estrellas()
	elif nivel == 3: #NivelTres
		puntaje = Persistencia.getPuntajeNivelTres()
		if(puntaje >= estrellasN3[0]):
			tres_estrellas_dorada()
		elif(puntaje >= estrellasN3[1]):
			dos_estrellas_dorada()
		elif(puntaje >= estrellasN3[2]):
			una_estrellas_dorada()
		else:
			cero_estrellas()
	elif nivel == 4:
		puntaje = Persistencia.getPuntajeNivelCuatro()
		cero_estrellas()
		#Logica de estrellas del nivel Cuatro
	
	show()

func show_game_over():
	$WindowContainer/Title.text = tr("PAUSE_MENU_GAMEOVER")
	$WindowContainer/PlayButton.hide()
	$WindowContainer/RetryButton.show()
	show()

func show_you_win(nivel,puntos):
	$WindowContainer/Title.text = tr("PAUSE_MENU_YOUWIN")
	$WindowContainer/PlayButton.hide()
	$WindowContainer/RetryButton.show()
	show()
	match nivel:
		1:
			if(puntos>6000):
				stars_condition(3)
			elif(puntos>4000):
				stars_condition(2)
			else:
				stars_condition(1)
		2:
			if(puntos>4000):
				stars_condition(3)
			elif(puntos>2000):
				stars_condition(2)
			else:
				stars_condition(1)
		3:
			if(puntos==1120):
				stars_condition(3)
			elif(puntos>=700):
				stars_condition(2)
			else:
				stars_condition(1)
		4:
			pass
	
	
func stars_condition(cant_estrellas): 
	#Silver Stars
	$AnimationPlayer.play("Silver Stars")
	yield(get_tree().create_timer(1.5), "timeout")
	#Golden Stars
	if (cant_estrellas == 1):
		$AnimationPlayer.play("1 Golden Star")
	elif (cant_estrellas == 2):
		$AnimationPlayer.play("2 Golden Star")
	elif (cant_estrellas == 3):
		$AnimationPlayer.play("3 Golden Star")
	yield(get_tree().create_timer(2.5), "timeout") 

func cero_estrellas():
	estrella1.play("empty")
	estrella2.play("empty")
	estrella3.play("empty")

func una_estrellas_dorada():
	estrella1.play("gold")
	estrella2.play("silver")
	estrella3.play("silver")

func dos_estrellas_dorada():
	estrella1.play("gold")
	estrella2.play("gold")
	estrella3.play("silver")

func tres_estrellas_dorada():
	estrella1.play("gold")
	estrella2.play("gold")
	estrella3.play("gold")

func show_dialog():
	$WindowContainer.hide()
	$ColorRect.hide()
	$WindowDialog.popup()

func hide_dialog():
	$WindowDialog.hide()
	$WindowContainer.show()
	$ColorRect.show()

func _on_PlayButton_pressed():
	emit_signal("play")

func _on_InfoButton_pressed():
	show_dialog()

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	get_tree().paused = false

func _on_RetryButton_pressed():
	emit_signal("retry")

func _on_AcceptButton_pressed():
	hide_dialog()

func _on_WindowDialog_hide():
	hide_dialog()
