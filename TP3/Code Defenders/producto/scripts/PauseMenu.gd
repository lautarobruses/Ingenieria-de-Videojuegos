extends Node2D

signal play

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_PlayButton_pressed():
	emit_signal("play")

func _on_InfoButton_pressed():
	pass # Replace with function body.

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	get_tree().paused = false

func _on_RetryButton_pressed():
	pass # Replace with function body.
