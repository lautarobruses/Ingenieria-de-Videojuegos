extends Node2D

const MAX_LENGTH = 5000

#onready var beam = $cuerpoRayo
#onready var end = $fin
#onready var rayCast2D = $RayCast2D
onready var player = get_node("../Jugador")
var player_position
onready var inicio = 0
var max_cast_to
var target_position = Vector2()

func init(position,target):
	global_position = position
	target_position = target

func _physics_process(delta):
	if inicio == 0:
		inicio = 1
		player_position = player.position
		max_cast_to = target_position * MAX_LENGTH
	
	$RayCast2D.cast_to = max_cast_to
	$cuerpoRayo.rotation = $RayCast2D.cast_to.angle()
	$cuerpoRayo.region_rect.end.x = $fin.position.length()
	$inicioRayo.rotation = $RayCast2D.cast_to.angle()
	if $RayCast2D.is_colliding():
		$fin.global_position = $RayCast2D.get_collision_point()
	else:
		$fin.global_position = $RayCast2D.cast_to


func _on_NaveCuatro_destruyeLaser():
	queue_free()
	pass # Replace with function body.
