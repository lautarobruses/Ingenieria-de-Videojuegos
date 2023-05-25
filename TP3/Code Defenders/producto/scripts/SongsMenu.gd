extends "res://scripts/BasicMenu.gd"

signal play_song(song)

var url: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_MainPlayButton_pressed():
	emit_signal("play_song", 0)

func _on_MainInfoButton_pressed():
	url = "https://www.newgrounds.com/audio/listen/503544"
	show_dialog()

func _on_PlayButton1_pressed():
	emit_signal("play_song", 1)

func _on_InfoButton1_pressed():
	url = "https://www.newgrounds.com/audio/listen/623104"
	show_dialog()

func _on_PlayButton2_pressed():
	emit_signal("play_song", 2)

func _on_InfoButton2_pressed():
	url = "https://www.newgrounds.com/audio/listen/1029200"
	show_dialog()

func _on_PlayButton3_pressed():
	emit_signal("play_song", 3)

func _on_InfoButton3_pressed():
	url = "https://www.newgrounds.com/audio/listen/547884"
	show_dialog()

func _on_PlayButton4_pressed():
	emit_signal("play_song", 4)

func _on_InfoButton4_pressed():
	url = "https://www.newgrounds.com/audio/listen/1204602"
	show_dialog()

func show_dialog():
	$WindowContainer.hide()
	$WindowDialog.popup()

func hide_dialog():
	$WindowDialog.hide()
	$WindowContainer.show()

func _on_AcceptButton_pressed():
	OS.shell_open(url)

func _on_CancelButton_pressed():
	hide_dialog()

func _on_WindowDialog_hide():
	hide_dialog()
