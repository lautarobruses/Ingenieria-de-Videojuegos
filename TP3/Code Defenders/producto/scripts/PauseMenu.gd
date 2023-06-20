extends Node2D

signal play
signal retry

func _ready():
	pass # Replace with function body.

func show_pause():
	$WindowContainer/Title.text = tr("PAUSE_MENU_PAUSE")
	$WindowContainer/PlayButton.show()
	$WindowContainer/RetryButton.hide()
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
