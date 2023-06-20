extends KinematicBody2D

export (int) var health = 110

const MASS = 1
const MAX_SPEED = 750
const ACCELERATION = 1500
const DECCELERATION = 1500

var projectile = preload("res://Player_Projectile.tscn")
var special_projectile = preload("res://Special_Projectile.tscn")
var screen_size # Size of the game window.
var current_components = [1,2,3,4,5,6,0,0]

var speed: float = 0
var target_angle: float = 0

var target_motion = Vector2()
var motion = Vector2()
var steering = Vector2()
var direction = Vector2()

var invulnerability: bool = false
var isFrozen = true

var fase #fase=0 en fase esbirros ; fase=1 en fase nave madre

signal sueltaPieza
signal disparoEspecial

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	if (!isFrozen):
		move(delta)
		if Input.is_action_just_pressed("shoot"):
			shoot()
		if Input.is_action_just_pressed("special_shoot"):
			if(fase==1):
				emit_signal("disparoEspecial")
		if Input.is_action_just_pressed("delete_component"):
			emit_signal("sueltaPieza")

func start():
	show()
	$AnimationPlayer.play("Start")

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

func shoot_power():
	var sp = special_projectile.instance()
	sp.setConfiguration(current_components)
	sp.start($ProjectilePosition.global_position, rotation)
	get_parent().add_child(sp)

func damage_player(damage):
	health -= damage
	$InvulnerableTimer.start()
	invulnerability = true

func hitted(damage):
	damage_player(damage)
	$CollisionPolygon2D.set_deferred("disabled", true)

func freeze():
	isFrozen = true
	$CollisionPolygon2D.disabled = true

func unfreeze():
	isFrozen = false
	$CollisionPolygon2D.disabled = false

func blow():
	freeze()
	$CollisionPolygon2D.disabled = true
	$AnimatedSprite.visible = false
	$AnimatedBlast.visible = true
	$AnimatedBlast.play("default")
	yield(get_tree().create_timer(1.0), "timeout")
	hide()
	position = Vector2(-200, 540)

func _on_InvulnerableTimer_timeout():
	$CollisionPolygon2D.set_deferred("disabled", false)
	invulnerability = false

func setComponents(palabra):
	current_components = palabra.duplicate()
	shoot_power()
