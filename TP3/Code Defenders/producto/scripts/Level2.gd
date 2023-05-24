extends "res://scripts/Level.gd"

export var song: AudioStream

var boss1 = preload("res://Boss1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
#	start_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
