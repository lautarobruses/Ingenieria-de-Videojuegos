extends CanvasLayer

signal start_normal_round
signal boss_round

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the\nAsteroids!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$BossButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$BossButton.hide()
	$StartButton.hide()
	emit_signal("start_normal_round")

func _on_BossButton_pressed():
	$StartButton.hide()
	$BossButton.hide()
	emit_signal("boss_round")
	
func _on_MessageTimer_timeout():
	$Message.hide()
	
