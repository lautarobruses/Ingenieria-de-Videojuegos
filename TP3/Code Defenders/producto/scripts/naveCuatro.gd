extends KinematicBody2D

onready var componente = preload("res://Componente.tscn")
var laser = preload("res://Escenas/Laser.tscn")

onready var player = get_node("../Player")

const vidas = 2
var velocidad = 2
var player_position
var target_position
var golpes = 0

var laser1
var parado=0
var moviendo=0
var puntaje = 500
signal destruyeLaser
var weight = 0.05
var UltAnimacion
var exploto = 0
var salirDeLaPantalla = 0;
var objetivo


func _ready():
	play("normal")

func _physics_process(delta):
	if salirDeLaPantalla==0:
		if $TiempoParado.time_left == 0 and !exploto:
			#eliminaLaser()
			if moviendo == 0:
				$TiempoMovimiento.start()
				moviendo=1
				parado=0
			se_mueve(delta)
		
		if $TiempoMovimiento.time_left == 0 or exploto:
			#disparaLaser()
			if parado == 0:
				$TiempoParado.start()
				parado=1
				moviendo=0
			$turbo.hide()
	else:
		target_position = (objetivo - position).normalized()
		look_at(objetivo)
		var collision = move_and_collide(target_position * velocidad)

func se_mueve(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	rotation = lerp_angle(rotation, target_position.angle(), weight)
	$turbo.show()
	$turbo.play("turbo")
	var collision = move_and_collide(target_position * velocidad)
	if collision:
		if collision.collider.has_method("on_player_get_hit"):
			collision.collider.on_player_get_hit()

func hitted(damage):
	golpes += 1
	if golpes == vidas:
		get_parent().sumaPuntaje(puntaje)
		exploto = 1
		$turbo.hide()
		get_parent().remove_child(laser1)
		emit_signal("destruyeLaser")
		play("explosion")
		$CollisionShape2D.disabled = true

func disparaLaser():
	if !exploto:
		laser1 = laser.instance() 
		laser1.init($Position2D.global_position,target_position)
		get_parent().add_child(laser1)
		#self.connect("destruyeLaser",get_parent().get_node(laser1),"_on_NaveCuatro_destruyeLaser")

func eliminaLaser():
	get_parent().remove_child(laser1)
	emit_signal("destruyeLaser")

func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var new_componente = componente.instance()
		get_parent().add_child(new_componente)
		new_componente.init(position, 4)
		queue_free()
	
func play(animacion):
	$nave.play(animacion)
	UltAnimacion = animacion

func _on_TiempoMovimiento_timeout():
	disparaLaser()

func _on_TiempoParado_timeout():
	eliminaLaser()
	
func salirDeLaPantalla():
	salirDeLaPantalla=1
	if (position.distance_to(Vector2(2000,-40)) < position.distance_to(Vector2(2000,1080))):
		objetivo = Vector2(2000,-40)
	else:
		objetivo = Vector2(2000,1080)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
