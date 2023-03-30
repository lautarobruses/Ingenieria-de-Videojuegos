extends KinematicBody2D

export(PackedScene) var bad_projectile_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _physics_process(delta):
	pass

func start(pos):
	position = pos
	$CollisionPolygon2D.disabled = false
	show()
	charge()

func charge():
	var projectile1 = bad_projectile_scene.instance()
	var projectile2 = bad_projectile_scene.instance()
	var projectile3 = bad_projectile_scene.instance()
	var projectile4 = bad_projectile_scene.instance()
	projectile1.charging($CanonPosition1.global_position)
	projectile2.charging($CanonPosition2.global_position)
	projectile3.charging($CanonPosition3.global_position)
	projectile4.charging($CanonPosition4.global_position)
	get_parent().add_child(projectile1)
	get_parent().add_child(projectile2)
	get_parent().add_child(projectile3)
	get_parent().add_child(projectile4)
	$CharginTimer.start()
	
func shoot():
	pass

func _on_CharginTimer_timeout():
	pass # Replace with function body.
