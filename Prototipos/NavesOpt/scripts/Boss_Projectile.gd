extends "res://scripts/Projectile.gd"

onready var target = get_node("../Player")

func charging(pos):
	position = pos
	rotation = 0
	$AnimatedSprite.animation = "charging"

func shoot():
	look_at(target.position)
	velocity = Vector2(speed, 0).rotated(rotation)
	$AnimatedSprite.animation = "shooted"

func blow():
	velocity = Vector2()
	$AnimatedSprite.animation = "blow"
	$CollisionShape2D.set_deferred("disabled", true)
	$BlowTimer.start()

func _on_BlowTimer_timeout():
	queue_free()
