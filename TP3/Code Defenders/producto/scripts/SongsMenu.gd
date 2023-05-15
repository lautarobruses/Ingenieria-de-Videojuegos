extends "res://scripts/BasicMenu.gd"

signal play_song(song)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_MainPlayButton_pressed():
	emit_signal("play_song", 0)

func _on_MainInfoButton_pressed():
	var url = "https://www.newgrounds.com/audio/listen/503544"
	OS.shell_open(url)

func _on_PlayButton1_pressed():
	emit_signal("play_song", 1)

func _on_InfoButton1_pressed():
	var url = "https://www.newgrounds.com/audio/listen/623104"
	OS.shell_open(url)

func _on_PlayButton2_pressed():
	emit_signal("play_song", 2)

func _on_InfoButton2_pressed():
	var url = "https://www.newgrounds.com/audio/listen/1029200"
	OS.shell_open(url)

func _on_PlayButton3_pressed():
	emit_signal("play_song", 3)

func _on_InfoButton3_pressed():
	pass # Replace with function body.

func _on_PlayButton4_pressed():
	emit_signal("play_song", 4)

func _on_InfoButton4_pressed():
	pass # Replace with function body.
