extends KinematicBody2D

export (int) var damage = 100
var speed = 750
var velocity = Vector2()

func start(pos, dir):
	rotation = dir - PI/2
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)
	$AnimatedSprite.play()

func _physics_process(delta):
	var collision = move_and_collide(velocity * -delta)
	if collision:
#		velocity = velocity.bounce(collision.normal)
		queue_free()
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
