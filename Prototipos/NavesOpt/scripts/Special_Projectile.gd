extends KinematicBody2D

onready var target = get_node("../Boss")

const ROTATION_SPEED = 10.0

export (int) var speed
var configuration = []
var velocity = Vector2()

func start(pos, dir, config):
	rotation = dir
	position = pos
	velocity = Vector2(-speed, 0).rotated(dir)
	
	configuration.clear()
	configuration = config
	set_components(configuration)
	$CollisionShape2D.set_deferred("disabled", false)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		blow(true)
		if collision.collider.has_method("special_hitted"):
			collision.collider.special_hitted(configuration)
	
	$Component1.rotation += ROTATION_SPEED * delta
	$Component2.rotation += ROTATION_SPEED * delta
	$Component3.rotation += ROTATION_SPEED * delta
	$Component4.rotation += ROTATION_SPEED * delta
	$Component5.rotation += ROTATION_SPEED * delta
	$Component6.rotation += ROTATION_SPEED * delta



func set_components(configuration):
	$Core.visible = true
	for component in configuration:
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

func add_component(new_component):
	configuration.append(new_component)
	pass

func delete_component(component):
	configuration.pop_back(component)
	pass

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
