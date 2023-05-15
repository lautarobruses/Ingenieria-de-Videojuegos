extends AudioStreamPlayer

export var main_song: AudioStream
export var song1: AudioStream
export var song2: AudioStream
export var song3: AudioStream
export var song4: AudioStream

var current_song := stream setget set_current_song

# Called when the node enters the scene tree for the first time.
func _ready():
	set_current_song(0)

func set_current_song(song):
	if song == 0:
		current_song = main_song
	elif song == 1:
		current_song = song1
	elif song == 2:
		current_song = song2
	elif song == 3:
		current_song = song3
	elif song == 4:
		current_song = song4
		
	stream = current_song
	play()
