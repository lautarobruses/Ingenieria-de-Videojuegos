extends Node2D

var player = preload("res://Player.tscn")
var boss1 = preload("res://Boss1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	start_level()

func start_level():
	set_player()
	set_boss()
	$AnimationPlayer.play("main")
	pass

func set_player():
	$Player.start()

func set_boss():
	$Boss1.start()

func game_over():
	get_tree().quit()
	pass

func fase_esbirros():
	pass
	
func fin_fase_esbirros():
	pass

func by_defeating_boss():
	get_tree().quit()
	pass 
	
func _on_Boss_broken_shield():
	$BossHealthBar.start()
