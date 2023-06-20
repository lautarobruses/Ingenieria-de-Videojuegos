extends KinematicBody2D

export (int) var speed
export (int) var damage
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(-speed, 0).rotated(dir)
	$AnimatedSprite.animation = "shoot"

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
#		velocity = velocity.bounce(collision.normal)
		blow()
		if collision.collider.has_method("hitted"):
			collision.collider.hitted(damage)

func blow():
	velocity = Vector2()
#	$AnimatedSprite.set_scale(Vector2(0.15, 0.15))
	$AnimatedSprite.animation = "blow"
	$CollisionShape2D.set_deferred("disabled", true)
	$BlowTimer.start()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_ShootTimer_timeout():
	$AnimatedSprite.animation = "default"

func _on_BlowTimer_timeout():
	queue_free()
