extends KinematicBody2D
class_name disparo

export (int) var speed = 500
export (int) var damage = 10
var velocity = Vector2()

func start(pos,dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	var collision = move_and_collide(velocity * -delta)
	if collision:
#		velocity = velocity.bounce(collision.normal)
		queue_free()
		if collision.collider.has_method("hitted"):
			collision.collider.hitted(damage)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
