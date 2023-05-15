extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play(55.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
