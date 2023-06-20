extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu.visible = true
	#Persistencia.load_game()

func _on_main_menu():
	$MainMenu.visible = true
	$Transition.fade_out()
	
func _on_level_menu():
	$Transition.fade_in()
	$MainMenu.visible = false
	$LevelMenu.visible = true
	Persistencia.load_game()
	$Transition.fade_out()

func _on_controls_menu():
	$Transition.fade_in()
	$MainMenu.visible = false
	$ControlsMenu.visible = true
	$Transition.fade_out()

func _on_settings_menu():
	$Transition.fade_in()
	$MainMenu.visible = false
	$SettingsMenu.visible = true
	$Transition.fade_out()

func _on_songs_menu():
	$Transition.fade_in()
	$MainMenu.visible = false
	$SongsMenu.visible = true
	$Transition.fade_out()

func _on_LevelMenu_main_menu():
	$Transition.fade_in()
	$LevelMenu.visible = false
	$MainMenu.visible = true
	$Transition.fade_out()

func _on_ControlsMenu_main_menu():
	$Transition.fade_in()
	$ControlsMenu.visible = false
	$MainMenu.visible = true
	$Transition.fade_out()

func _on_SettingsMenu_main_menu():
	$Transition.fade_in()
	$SettingsMenu.visible = false
	$MainMenu.visible = true
	$Transition.fade_out()

func _on_SongsMenu_main_menu():
	$Transition.fade_in()
	$SongsMenu.visible = false
	$MainMenu.visible = true
	$Transition.fade_out()

func _on_play_song(song):
	$MainSong.set_current_song(song)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		Persistencia.save_game()
