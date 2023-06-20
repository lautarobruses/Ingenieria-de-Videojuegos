extends KinematicBody2D

var vidas
var velocidad
var golpes = 0
var damage = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tipoNave
var UltAnimacion
var esCorrecto

# Called when the node enters the scene tree for the first time.
func _ready():
	velocidad = 3
	vidas = 1
	rotation_degrees = 180
	$AnimationPlayer.play("MovVertical")
#	$turbo.play("fuego")
#	play("normal")
	match tipoNave:
		1:
			$AnimatedSprite.play("naveUno")
		2:
			$AnimatedSprite.play("naveDos")
		3:
			$AnimatedSprite.play("naveTres")
		4:
			$AnimatedSprite.play("naveCuatro")
		5:
			$AnimatedSprite.play("naveCinco")
		6:
			$AnimatedSprite.play("naveSeis")
	pass # Replace with function body.


func _physics_process(delta):
	var objetivo = Vector2(-1,0);
	var collision = move_and_collide(objetivo * velocidad)
	if collision:
		if collision.collider.has_method("on_player_get_hit"):
			collision.collider.on_player_get_hit()

func setTipoNave(tipo):
	tipoNave = tipo
	
func hitted(damage):
	golpes += 1
	if golpes == vidas:
		if(esCorrecto):
			get_parent().sumaPuntaje(20)
		else:
			get_parent().sumaPuntaje(-20)
		#$turbo.hide()
		play("explosion")
		$CollisionShape2D.disabled = true
		
func play(animacion):
	$AnimatedSprite.play(animacion)
	UltAnimacion = animacion


func _on_AnimatedSprite_animation_finished():
	if UltAnimacion == "explosion":
		queue_free()
	pass # Replace with function body.

func SetEsCorrecto(es):
	esCorrecto = es
