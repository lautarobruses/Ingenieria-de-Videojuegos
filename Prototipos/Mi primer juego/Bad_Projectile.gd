extends KinematicBody2D

onready var target = get_node("../Player")

var speed = 0
var velocity = Vector2()

func charging(pos):
	position = pos
	rotation = 0
	$AnimatedSprite.animation = "charging"
	$CollisionShape2D.disabled = true

func shoot():
	speed = 350
	rotation = target
	velocity = Vector2(speed, 0).rotated(rotation)
	$AnimatedSprite.animation = "shooted"
	$CollisionShape2D.disabled = false
	
func _physics_process(delta):
	$AnimatedSprite.play()
	var collision = move_and_collide(velocity * -delta)
	if collision:
#		$AnimatedSprite.stop()
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
