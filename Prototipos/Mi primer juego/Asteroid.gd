extends KinematicBody2D

var velocity = Vector2()

func _ready():
	$AnimatedSprite.playing = true
	var asteroid_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = asteroid_types[randi() % (asteroid_types.size()-1)]

func setVelocity(vel):
	velocity = vel

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
#		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("on_player_get_hit"):
			collision.collider.on_player_get_hit()

func hit():
	$CollisionShape2D.disabled = true
	$AnimatedSprite.animation = "Explotion"
	$ExplotionTimer.start()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_ExplotionTimer_timeout():
	queue_free()
