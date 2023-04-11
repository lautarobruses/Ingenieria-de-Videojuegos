extends KinematicBody2D

export(PackedScene) var bad_projectile_scene
export (int) var health = 1000
export (int) var damage = 50

var canons = null
var projectile_positions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	position = Vector2(1550, 360)

func _physics_process(_delta):
	pass

func start():
	show()
	canons = get_tree().get_nodes_in_group("Canons")
	
	$CollisionPolygon2D.disabled = true
	$AnimationPlayer.play("Aparicion")
	$AnimationPlayer.queue("Embestir")
	$AnimationPlayer.queue("Shoot fase")
	$AnimationPlayer.queue("Cambiar lado")
	$AnimationPlayer.queue("Shoot fase")

func stop():
	hide()
	if ($ShootTimer.is_stopped() != true):
		$ShootTimer.stop()
	get_tree().call_group("bad_projectiles", "queue_free")
	queue_free()

func shoot():
	#find a random free canon
	var free_canon = find_a_free_canon()
	#instance a new projectile
	var new_projectile = bad_projectile_scene.instance()
	new_projectile.charging(free_canon)
	
	get_parent().add_child(new_projectile)
	
	projectile_positions.append(free_canon)
	yield($ShootTimer, "timeout")
	projectile_positions.remove(projectile_positions.find(free_canon))

func find_a_free_canon():
	var random_canon = canons[randi() % canons.size()]
	var random_position = random_canon.global_position
	
	while random_position in projectile_positions:
		random_canon = canons[randi() % canons.size()]
		random_position = random_canon.global_position
		
	return random_position

func damage_boss(damage):
	health -= damage

func _on_Hitbox_area_entered(area):
	if area.get_parent().is_in_group("Projectile"):
		damage_boss(area.get_parent().damage)

func _on_ShootTimer_timeout():
	shoot()
