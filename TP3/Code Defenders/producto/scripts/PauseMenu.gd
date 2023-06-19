extends Node2D

signal play
signal retry

func _ready():
	pass # Replace with function body.

func show_pause():
	$Title.text = tr("PAUSE_MENU_PAUSE")
	$PlayButton.show()
	$RetryButton.hide()
	show()
	
func show_game_over():
	$Title.text = tr("PAUSE_MENU_GAMEOVER")
	$PlayButton.hide()
	$RetryButton.show()
	show()

func show_you_win():
	$Title.text = tr("PAUSE_MENU_YOUWIN")
	$PlayButton.hide()
	$RetryButton.show()
	show()
	stars_condition()
	#Aca tengo que preguntar si el puntaje obtenido es mayor al puntaje guardado
	#lo piso
	#persistencia.save()
	
func stars_condition(): 
	var cant_estrellas = 1
	#Como se determinan las estrellas???
	
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
	#COMPLETAR LOGICA DE ESTRELLAS DORADAS

func _on_PlayButton_pressed():
	emit_signal("play")

func _on_InfoButton_pressed():
	pass # Replace with function body.

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	get_tree().paused = false

func _on_RetryButton_pressed():
	emit_signal("retry")
