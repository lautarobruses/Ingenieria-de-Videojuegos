extends Node2D

var player = preload("res://Player.tscn")
var boss1 = preload("res://Boss1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_level()

func start_level():
	set_player()
	set_boss()
	
func set_player():
	var new_player = player.instance()
	add_child(new_player)
	new_player.start(Vector2(640,360))

func set_boss():
	var boss = boss1.instance()
	add_child(boss)

func game_over():
	pass

func fase_esbirros():
	pass
	
func fin_fase_esbirros():
	pass
