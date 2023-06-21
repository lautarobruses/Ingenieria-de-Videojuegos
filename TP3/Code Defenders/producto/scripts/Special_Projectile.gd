extends KinematicBody2D

const ROTATION_SPEED = 10.0

export (int) var speed
var configuration 
var velocity = Vector2()
var nivel

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(-speed, 0).rotated(dir)

	$CollisionShape2D.set_deferred("disabled", false)

func setConfiguration(config):
	configuration = config.duplicate()
	set_components(configuration)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("special_condition"):
			var hit = collision.collider.special_condition(configuration)
			print(hit)
			blow(hit)
	
	$Component1.rotation += ROTATION_SPEED * delta
	$Component2.rotation += ROTATION_SPEED * delta
	$Component3.rotation += ROTATION_SPEED * delta
	$Component4.rotation += ROTATION_SPEED * delta
	$Component5.rotation += ROTATION_SPEED * delta
	$Component6.rotation += ROTATION_SPEED * delta

func set_components(config):
	$Core.visible = true
	for component in config:
		if component == 1:
			$Component1.visible = true
		elif component == 2:
			$Component2.visible = true
		elif component == 3:
			$Component3.visible = true
		elif component == 4:
			$Component4.visible = true
		elif component == 5:
			$Component5.visible = true
		elif component == 6:
			$Component6.visible = true

func hit(shield_configuration):
	for components in configuration:
		if shield_configuration.count(components) == 0:
			blow(false)
	blow(true)

func blow(good_hit):
	velocity = Vector2()
	
	if good_hit == true:
		$BurstAnimation.play("good_hit")
	else:
		$BurstAnimation.play("bad_hit")
	
	$BurstAnimation.visible = true
	$BlowTimer.start()
	$CollisionShape2D.set_deferred("disabled", true)
	get_tree().call_group("Components", "hide")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_BlowTimer_timeout():
	queue_free()
