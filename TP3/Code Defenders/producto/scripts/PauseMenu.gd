extends Node2D

signal play
signal retry

func _ready():
	pass # Replace with function body.

func show_pause():
	$Title.text = "Pause"
	$PlayButton.show()
	$RetryButton.hide()
	show()
	
func show_game_over():
	$Title.text = "Game Over"
	$PlayButton.hide()
	$RetryButton.show()
	show()

func show_you_win():
	$Title.text = "You win"
	$PlayButton.hide()
	$RetryButton.show()
	show()

func _on_PlayButton_pressed():
	emit_signal("play")

func _on_InfoButton_pressed():
	pass # Replace with function body.

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	get_tree().paused = false

func _on_RetryButton_pressed():
	emit_signal("retry")
