extends KinematicBody2D

export (int) var health = 100

const MASS = 2
const MAX_SPEED = 500
const ACCELERATION = 2000
const DECCELERATION = 2000

var projectile = preload("res://Escenas/Player_Projectile.tscn")
var special_projectile = preload("res://Escenas/Special_Projectile.tscn")
var screen_size # Size of the game window.
var invulnerability: bool = false
var current_components = [0,0,0]

var speed: float = 0
var target_angle: float = 0

var target_motion = Vector2()
var motion = Vector2()
var steering = Vector2()
var direction = Vector2()

onready var timer = get_parent().get_node("tiempoDeRetirada")

signal sueltaPieza
signal disparoEspecial

func _ready():
	screen_size = get_viewport_rect().size
#	hide()

func _physics_process(delta):
	move(delta)

	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("power"):
		if(timer.time_left==0):
			emit_signal("disparoEspecial")
	if Input.is_action_just_pressed("sueltaPieza"):
		emit_signal("sueltaPieza")

func start(pos):
	position = pos
	show()

func move(delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if direction != Vector2():
		speed += ACCELERATION * delta
	else:
		speed -= DECCELERATION * delta
		
	speed = clamp(speed, 0, MAX_SPEED)
	
	target_motion = speed * direction.normalized() * delta
	
	steering = target_motion - motion
	
	if steering.length() > 1:
		steering = steering.normalized()
	
	motion += steering / MASS
	
	if invulnerability == true:
		$AnimatedSprite.animation = "invulnerable"
	else:
		if speed == 0:
			motion = Vector2()
			$AnimatedSprite.animation = "default"

	var collision = move_and_collide(motion)
	if collision && collision.collider.damage != null:
		hitted(collision.collider.damage)
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if motion != Vector2():
		target_angle = atan2(motion.x, motion.y) + PI/2
		rotation = -target_angle

func shoot():
	var p = projectile.instance()
	p.start($ProjectilePosition.global_position, rotation)
	get_parent().add_child(p)
	$ShootSound.play()

func shoot_power():
	var sp = special_projectile.instance()
	sp.start($ProjectilePosition.global_position, rotation, current_components)
	get_parent().add_child(sp)

func dead():
	hide()
	$CollisionPolygon2D.disabled = true
#	queue_free()

func damage_player(damage):
	print(health)
	health -= damage
	$InvulnerableTimer.start()
	invulnerability = true

func hitted(damage):
	damage_player(damage)
	$CollisionPolygon2D.set_deferred("disabled", true)

func _on_InvulnerableTimer_timeout():
	$CollisionPolygon2D.set_deferred("disabled", false)
	invulnerability = false
	
func setComponents(componentesBarra):
	current_components = componentesBarra
	var sp = special_projectile.instance()
	sp.start($ProjectilePosition.global_position, rotation, current_components)
	get_parent().add_child(sp)
