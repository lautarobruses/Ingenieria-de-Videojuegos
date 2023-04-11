extends KinematicBody2D

export (int) var damage = 10

onready var target = get_node("../Player")

var speed = 0
var velocity = Vector2()

func charging(pos):
	position = pos
	rotation = 0
	$AnimatedSprite.animation = "charging"
	$CollisionShape2D.disabled = true
	$Hitbox/HitboxArea.disabled = true

func shoot():
	speed = 350
	look_at(target.position)
	velocity = Vector2(speed, 0).rotated(rotation)
	$AnimatedSprite.animation = "shooted"
	$Hitbox/HitboxArea.disabled = false

func _physics_process(delta):
	$AnimatedSprite.play()
	move_and_collide(velocity * delta)
#	if collision:
#		if collision.collider.has_method("on_player_get_hit"):
#			collision.collider.on_player_get_hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_CharginTimer_timeout():
	shoot()
