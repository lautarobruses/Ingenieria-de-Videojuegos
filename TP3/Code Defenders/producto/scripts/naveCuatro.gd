extends KinematicBody2D

const vidas = 2

onready var player = get_node("../Player")
var velocidad = 2
var player_position
var target_position
var golpes = 0
var laser = preload("res://Escenas/Laser.tscn")
var laser1
var parado=0
var moviendo=0
var puntaje = 500
signal destruyeLaser
var weight = 0.05
var UltAnimacion
var exploto = 0
onready var parte = preload("res://Escenas/PremioNaveCuatro.tscn")

var salirDeLaPantalla = 0;
var objetivo

# Called when the node enters the scene tree for the first time.
func _ready():
	play("normal")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	pass # Replace with function body.


func eliminaLaser():
	get_parent().remove_child(laser1)
	emit_signal("destruyeLaser")
	pass # Replace with function body.


func _on_nave_animation_finished():
	if UltAnimacion == "explosion":
		var parte1 = parte.instance()
		get_parent().add_child(parte1)
		parte1.init(position,4)
		queue_free()
	pass # Replace with function body.
	
func play(animacion):
	$nave.play(animacion)
	UltAnimacion = animacion


func _on_TiempoMovimiento_timeout():
	disparaLaser()
	pass # Replace with function body.


func _on_TiempoParado_timeout():
	eliminaLaser()
	pass # Replace with function body.
	
func salirDeLaPantalla():
	salirDeLaPantalla=1
	if (position.distance_to(Vector2(2000,-40)) < position.distance_to(Vector2(2000,1080))):
		objetivo = Vector2(2000,-40)
	else:
		objetivo = Vector2(2000,1080)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
