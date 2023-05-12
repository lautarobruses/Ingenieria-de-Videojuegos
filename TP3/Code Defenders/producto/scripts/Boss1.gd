extends KinematicBody2D

var projectile = preload("res://Boss_Projectile.tscn")
export (int) var health = 1000
export (int) var damage = 45

var canons = null
var projectile_positions = []
var shot_type: String

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
#	start()
#	position = Vector2(1550, 360)

func start():
	show()
	canons = get_tree().get_nodes_in_group("Canons")

func stop():
	hide()
	if ($ShootTimer.is_stopped() != true):
		$ShootTimer.one_shot = true
	get_tree().call_group("bad_projectiles", "queue_free")
	queue_free()

func change_shoot(type):
	shot_type = type

func emerge():
	$AnimationPlayer.play("Emerge")
#	$AnimationPlayer.queue("Shoot Target")
	$AnimationPlayer.queue("Shoot Horizontal")

func first_phase():
	$AnimationPlayer.play("Shoot Target")

func shoot():
	#find a random free canon
	var free_canon = find_a_free_canon()
	#instance a new projectile
	var new_projectile = projectile.instance()
	new_projectile.charging(free_canon)
	get_parent().add_child(new_projectile)
	
	projectile_positions.append(free_canon)
	print(shot_type)
	
	print("0")
	if (shot_type == "waiting"):
		new_projectile.add_to_group("Waiting Shots")
	else:
		print("1")
		yield(get_tree().create_timer(0.25), "timeout")
		print("2")
		if (shot_type == "horizontal"):
			new_projectile.shoot_h()
		elif (shot_type == "target"):
			print("3")
			new_projectile.shoot_target()

	projectile_positions.remove(projectile_positions.find(free_canon))

func find_a_free_canon():
	var random_canon = canons[randi() % canons.size()]
	var random_position = random_canon.global_position
	
	while random_position in projectile_positions:
		random_canon = canons[randi() % canons.size()]
		random_position = random_canon.global_position
	
	return random_position

func shoot_everything():
	var shots = get_tree().get_nodes_in_group("Waiting Shots")
	print("shoot_everything")
	print(shot_type)
	if (shot_type == "horizontal"):
		for shot in shots:
			shot.shoot_h()
	elif (shot_type == "target"):
		for shot in shots:
			shot.shoot_target()

func hitted(damage_):
	if (damage_ != null):
		damage_boss(damage_)

func damage_boss(damage_hitted):
	health -= damage_hitted

func _on_ShootTimer_timeout():
	shoot()
