extends Control

func _ready():
	$Music.play(55.0)

func _on_StartButton_pressed():
	$Transition.next("res://LevelMenu.tscn")

func _on_ControlsButton_pressed():
	pass # Replace with function body.

func _on_SettingsButton_pressed():
	pass # Replace with function body.

func _on_SongsButton_pressed():
	pass # Replace with function body.
	
func _on_QuitButton_pressed():
	get_tree().quit()
