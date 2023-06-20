extends KinematicBody2D

signal broken_shield

var projectile = preload("res://Boss_Projectile.tscn")
var blast = preload("res://Blast.tscn")

export (int) var health = 10
export (int) var damage = 45

var rotation_speed = 0.5

func _ready():
	hide()

func _physics_process(delta):
	rotate(rotation_speed * delta)

func start():
	show()

func stop():
	if ($ShootTimer.is_stopped() != true):
		$ShootTimer.one_shot = true
	get_tree().call_group("bad_projectiles", "queue_free")
	$AnimationPlayer.stop()
	$AnimationPlayer.clear_queue()
	$AnimationPlayer.play("Defeated")
	defeated()
	yield(get_tree().create_timer(5), "timeout")
	queue_free()

func emerge():
	$AnimationPlayer.play("Emerge")
	$AnimationPlayer.queue("Move R-Center")
	$AnimationPlayer.queue("Shoot From Center")

func first_phase():
	pass

func second_phase():
	pass

func third_phase():
	pass

func defeated():
	var rectangle_shape = $BlastSpawnArea/CollisionShape2D.get_shape()

	while true:
		var x = rand_range(rectangle_shape.extents.x * -1, rectangle_shape.extents.x)
		var y = rand_range(rectangle_shape.extents.y * -1, rectangle_shape.extents.y)
		var random_position = Vector2(x, y)
		
		var new_blast = blast.instance()
		new_blast.global_position = random_position
		add_child(new_blast)
		yield(get_tree().create_timer(0.25), "timeout")

func shoot_from_center():
	var angle = deg2rad(rand_range(0, 360))
	
	var new_projectile = projectile.instance()
	# Ajusta la posición inicial y velocidad del proyectil
	new_projectile.position = $CenterPosition.position
	new_projectile.shoot_direction(angle)
	
	# Agrega el proyectil al árbol de escena
	get_parent().add_child(new_projectile)

func hitted(damage_):
	if (damage_ != null):
		damage_boss(damage_)

func damage_boss(damage_hitted):
	health -= damage_hitted

func set_shooting_speed(time):
	$ShootTimer.wait_time = time

func _on_ShootTimer_timeout():
	shoot_from_center()
	
func _on_Shield_broken():
	emit_signal("broken_shield")
