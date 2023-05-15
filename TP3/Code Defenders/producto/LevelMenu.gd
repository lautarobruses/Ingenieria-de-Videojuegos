extends Control

var carousel_items = [1,2,3,4,5]
var current_index = 0

func _ready():
	pass

func change_level_name(level_name_node):
	var level_name: String
	
	if current_index == 0:
		level_name = "Codigos Bloque"
	elif current_index == 1:
		level_name = "Codigos Singulares"
	elif current_index == 2:
		level_name = "Codigos Univocos"
	elif current_index == 3:
		level_name = "Codigos Intantaneos"
	elif current_index == 4:
		level_name = "Proximamente"
	
	level_name_node.set_text(level_name)

func set_configuration_level(action):
	
	#ACA TENGO QUE ESTABLECER LA INFORMACION DE LAS ESTRELLAS Y
	#LOS LINKS DE INFOBUTTON Y PLAYBUTTON
	
	if current_index == 0:
		if action == "Forward":
			pass
	elif current_index == 1:
		pass
	elif current_index == 2:
		pass
	elif current_index == 3:
		pass

func animate_buttons():
	$InfoButton.visible = false
	$PlayButton.visible = false
	$CloseButton.visible = false
	
	$PreviousWindow/PInfoSprite.visible = true
	$PreviousWindow/PPlaySprite.visible = true
	$PreviousWindow/PCloseSprite.visible = true
	
	$NextWindow/NInfoSprite.visible = true
	$NextWindow/NPlaySprite.visible = true
	$NextWindow/NCloseSprite.visible = true
	yield(get_tree().create_timer(1.0), "timeout")
	$InfoButton.visible = true
	$PlayButton.visible = true
	$CloseButton.visible = true
	
	$PreviousWindow/PInfoSprite.visible = false
	$PreviousWindow/PPlaySprite.visible = false
	$PreviousWindow/PCloseSprite.visible = false
	
	$NextWindow/NInfoSprite.visible = false
	$NextWindow/NPlaySprite.visible = false
	$NextWindow/NCloseSprite.visible = false

	if current_index == 4: #Proximamente
		$InfoButton.disabled = true
		$PlayButton.disabled = true
	else:
		$InfoButton.disabled = false
		$PlayButton.disabled = false

func slide_forward_buttons():
	pass

func _on_BackwardButton_pressed():
	current_index -= 1
	if current_index < 0:
		current_index = carousel_items.size() - 1
	
	$BackwardButton.disabled = true
	change_level_name($NextWindow/NextLevelName)
	animate_buttons()
	set_configuration_level("Backward")
	$AnimationPlayer.play("Slide Window Forward")
	yield(get_tree().create_timer(1.0), "timeout")
	$BackwardButton.disabled = false

func _on_ForwardButton_pressed():
	current_index += 1
	if current_index >= carousel_items.size():
		current_index = 0
	
	$ForwardButton.disabled = true
	change_level_name($PreviousWindow/PreviousLevelName)
	animate_buttons()
	set_configuration_level("Forward")
	$AnimationPlayer.play("Slide Window Backward")
	yield(get_tree().create_timer(1.0), "timeout")
	$ForwardButton.disabled = false

func _on_InfoButton_pressed():
	pass # Replace with function body.

func _on_PlayButton_pressed():
	if current_index == 0:
		get_tree().change_scene("res://Level.tscn")
	elif current_index == 1:
		pass
	elif current_index == 2:
		pass
	elif current_index == 3:
		pass

func _on_CloseButton_pressed():
	$Transition.next("res://MainMenu.tscn")
