extends Control

signal level_menu
signal controls_menu
signal settings_menu
signal songs_menu

func _ready():
	pass

func _on_StartButton_pressed():
	emit_signal("level_menu")

func _on_ControlsButton_pressed():
	emit_signal("controls_menu")

func _on_SettingsButton_pressed():
	emit_signal("settings_menu")

func _on_SongsButton_pressed():
	emit_signal("songs_menu")
	
func _on_QuitButton_pressed():
	get_tree().quit()
