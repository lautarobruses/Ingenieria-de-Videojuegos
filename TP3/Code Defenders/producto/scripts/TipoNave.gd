extends KinematicBody2D
class_name TipoNaveSimple

var puntaje = 100

var velocidad = 1
var vidas
var damage = 10
var golpes = 0
var UltAnimacion
var salir = 0;

onready var player = get_node("../Player")
var objetivo
var target_position

func _physics_process(_delta):
	if (salir == 0):
		objetivo = player.position
	else:
		velocidad = 7
	target_position = (objetivo - position).normalized()
	look_at(objetivo)
	var collision = move_and_collide(target_position * velocidad)
	if collision:
		if collision.collider.has_method("hitted"):
			collision.collider.hitted(damage)

func hitted(_damage):
	golpes += 1
	if golpes == vidas:
		get_parent().sumaPuntaje(puntaje)
		$turbo.hide()
		play("explosion")
		$CollisionShape2D.disabled = true
		
func play(animacion):
	$nave.play(animacion)
	UltAnimacion = animacion
	
func salirDeLaPantalla():
	salir = 1
	if (position.distance_to(Vector2(2000,-40)) < position.distance_to(Vector2(2000,1080))):
		objetivo = Vector2(2000,-40)
	else:
		objetivo = Vector2(2000,1080)
