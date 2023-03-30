extends Node2D

export(PackedScene) var asteroid_scene
var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	
	$HUD.show_game_over()
	
	$Music.stop()
	$BossMusic.stop()
	$DeathSound.play()

func start_normal_round():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	$Music.play()
	
	get_tree().call_group("asteroids", "queue_free")

func start_boss_round():
	$Player.start($StartPosition.position)
	$Boss.start($BossPosition.position)
	
	$HUD.update_score("")
	$HUD.show_message("Boss\nTime!")
	
	$BossMusic.play()

func _on_AsteroidTimer_timeout():
	# Create a new instance of the Mob scene.
	var asteroid = asteroid_scene.instance()

	# Choose a random location on Path2D.
	var asteroid_spawn_location = get_node("AsteroidPath/AsteroidSpawnLocation")
	asteroid_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = asteroid_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	asteroid.position = asteroid_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction

	# Choose the velocity for the asteroid.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
#	asteroid.linear_velocity = velocity.rotated(direction)
	asteroid.setVelocity(velocity.rotated(direction))

	# Spawn the mob by adding it to the Main scene.
	add_child(asteroid)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()

func _on_BossTimer_timeout():
	pass
