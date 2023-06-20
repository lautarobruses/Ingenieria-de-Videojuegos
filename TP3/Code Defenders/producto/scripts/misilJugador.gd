extends KinematicBody2D
class_name disparo

var speed = 600
var velocity = Vector2()
var damage = 10

func start(pos,dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	var collision = move_and_collide(velocity * -delta)
	if collision:
#		velocity = velocity.bounce(collision.normal)
		queue_free()
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
