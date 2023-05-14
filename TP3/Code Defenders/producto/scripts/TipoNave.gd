extends KinematicBody2D
class_name TipoNaveSimple

#register_class<TipoNave>

var velocidad = 1
var vidas
var damage = 10
var golpes = 0
var UltAnimacion
var salirDeLaPantalla = 0;

onready var player = get_node("../Player")
var objetivo
var target_position
#onready var misil = get_node("../Misilardo")

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (salirDeLaPantalla == 0):
		objetivo = player.position
	target_position = (objetivo - position).normalized()
	look_at(objetivo)
	var collision = move_and_collide(target_position * velocidad)
	if collision:
		if collision.collider.has_method("on_player_get_hit"):
			collision.collider.on_player_get_hit()

func hitted(damage):
	golpes += 1
	if golpes == vidas:
		$turbo.hide()
		play("explosion")
		$CollisionShape2D.disabled = true
		
func play(animacion):
	$nave.play(animacion)
	UltAnimacion = animacion
	
func salirDeLaPantalla():
	salirDeLaPantalla=1
	if (position.distance_to(Vector2(2000,-40)) < position.distance_to(Vector2(2000,1080))):
		objetivo = Vector2(2000,-40)
	else:
		objetivo = Vector2(2000,1080)
