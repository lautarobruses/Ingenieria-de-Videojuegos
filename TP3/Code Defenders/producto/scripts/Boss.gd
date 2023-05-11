extends KinematicBody2D

var projectile = preload("res://Boss_Projectile.tscn")
export (int) var health = 1000
export (int) var damage = 45

var canons = null
var projectile_positions = []

# Called when the node enters the scene tree for the first time.
func _ready():
#	hide()
	start()
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

func shoot():
	#find a random free canon
	var free_canon = find_a_free_canon()
	#instance a new projectile
	var new_projectile = projectile.instance()
	new_projectile.charging(free_canon)
	
	get_parent().add_child(new_projectile)
	
	projectile_positions.append(free_canon)
	
	yield(get_tree().create_timer(1.0), "timeout")
	new_projectile.shoot()
	projectile_positions.remove(projectile_positions.find(free_canon))

func find_a_free_canon():
	var random_canon = canons[randi() % canons.size()]
	var random_position = random_canon.global_position
	
	while random_position in projectile_positions:
		random_canon = canons[randi() % canons.size()]
		random_position = random_canon.global_position
		
	return random_position

func hitted(damage_):
	if (damage_ != null):
		damage_boss(damage_)

func damage_boss(damage_hitted):
	health -= damage_hitted

func _on_ShootTimer_timeout():
	shoot()
