extends "res://scripts/Level.gd"

export var song: AudioStream

var boss1 = preload("res://Boss1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	start_level()

func start_level():
	set_player()
	set_boss()
	$AnimationPlayer.play("main")
	set_music(song)

func set_boss():
	$Boss1.start()

func _on_Boss1_broken_shield():
	$BossHealthBar.start()
	pass # Replace with function body.
