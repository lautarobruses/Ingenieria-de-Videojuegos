extends Control

signal main_menu

var carousel_items = [1,2,3,4,5]
var current_index = 0

func _ready():
	Persistencia.load_game() #Cargo los puntajes viejos
	set_configuration_level($WindowContainer/PreviousWindow/PStar1,$WindowContainer/PreviousWindow/PStar2,$WindowContainer/PreviousWindow/PStar3)

func change_level_name(level_name_node):
	var level_name: String
	
	if current_index == 0:
		level_name = tr("LEVEL1_TITLE")
	elif current_index == 1:
		level_name = tr("LEVEL2_TITLE")
	elif current_index == 2:
		level_name = tr("LEVEL3_TITLE")
	elif current_index == 3:
		level_name = tr("LEVEL4_TITLE")
	elif current_index == 4:
		level_name = tr("LEVEL_SOON_TITLE")
	
	level_name_node.set_text(level_name)

func change_level_info(level_name_node):
	var level_info: String
	
	if current_index == 0:
		level_info = tr("LEVEL1_CONTENT")
	elif current_index == 1:
		level_info = tr("LEVEL2_CONTENT")
	elif current_index == 2:
		level_info = tr("LEVEL3_CONTENT")
	elif current_index == 3:
		level_info = tr("LEVEL4_CONTENT")
	elif current_index == 4:
		pass
	
	level_name_node.set_text(level_info)

func set_configuration_level(estrella1,estrella2,estrella3):
	var puntaje

	if current_index == 0: #NivelUno
		puntaje = Persistencia.getPuntajeNivelUno()
		if(puntaje>6000):
			tres_estrellas_dorada(estrella1,estrella2,estrella3)
		elif(puntaje>4000):
			dos_estrellas_dorada(estrella1,estrella2,estrella3)
		elif(puntaje>2000):
			una_estrellas_dorada(estrella1,estrella2,estrella3)
		else:
			cero_estrellas(estrella1,estrella2,estrella3)
	elif current_index == 1: #NivelDos
		puntaje = Persistencia.getPuntajeNivelDos()
		if(puntaje>4000):
			tres_estrellas_dorada(estrella1,estrella2,estrella3)
		elif(puntaje>3000):
			dos_estrellas_dorada(estrella1,estrella2,estrella3)
		elif(puntaje>2000):
			una_estrellas_dorada(estrella1,estrella2,estrella3)
		else:
			cero_estrellas(estrella1,estrella2,estrella3)
	elif current_index == 2: #NivelTres
		puntaje = Persistencia.getPuntajeNivelTres()
		if(puntaje==1120):
			tres_estrellas_dorada(estrella1,estrella2,estrella3)
		elif(puntaje>=700):
			dos_estrellas_dorada(estrella1,estrella2,estrella3)
		elif(puntaje>=400):
			una_estrellas_dorada(estrella1,estrella2,estrella3)
		else:
			cero_estrellas(estrella1,estrella2,estrella3)
	elif current_index == 3:
		puntaje = Persistencia.getPuntajeNivelCuatro()
		cero_estrellas(estrella1,estrella2,estrella3)
		#Logica de estrellas del nivel Cuatro

func cero_estrellas(estrella1,estrella2,estrella3):
	estrella1.play("empty")
	estrella2.play("empty")
	estrella3.play("empty")

func una_estrellas_dorada(estrella1,estrella2,estrella3):
	estrella1.play("gold")
	estrella2.play("silver")
	estrella3.play("silver")

func dos_estrellas_dorada(estrella1,estrella2,estrella3):
	estrella1.play("gold")
	estrella2.play("gold")
	estrella3.play("silver")

func tres_estrellas_dorada(estrella1,estrella2,estrella3):
	estrella1.play("gold")
	estrella2.play("gold")
	estrella3.play("gold")


func animate_buttons():
	$WindowContainer/InfoButton.visible = false
	$WindowContainer/PlayButton.visible = false
	$WindowContainer/CloseButton.visible = false
	
	$WindowContainer/PreviousWindow/PInfoSprite.visible = true
	$WindowContainer/PreviousWindow/PPlaySprite.visible = true
	$WindowContainer/PreviousWindow/PCloseSprite.visible = true
	
	$WindowContainer/NextWindow/NInfoSprite.visible = true
	$WindowContainer/NextWindow/NPlaySprite.visible = true
	$WindowContainer/NextWindow/NCloseSprite.visible = true
	yield(get_tree().create_timer(1.0), "timeout")
	$WindowContainer/InfoButton.visible = true
	$WindowContainer/PlayButton.visible = true
	$WindowContainer/CloseButton.visible = true
	
	$WindowContainer/PreviousWindow/PInfoSprite.visible = false
	$WindowContainer/PreviousWindow/PPlaySprite.visible = false
	$WindowContainer/PreviousWindow/PCloseSprite.visible = false
	
	$WindowContainer/NextWindow/NInfoSprite.visible = false
	$WindowContainer/NextWindow/NPlaySprite.visible = false
	$WindowContainer/NextWindow/NCloseSprite.visible = false

	if current_index == 4 or current_index == 3: #Proximamente
		$WindowContainer/InfoButton.disabled = true
		$WindowContainer/PlayButton.disabled = true
	else:
		$WindowContainer/InfoButton.disabled = false
		$WindowContainer/PlayButton.disabled = false

func _on_BackwardButton_pressed():
	current_index -= 1
	if current_index < 0:
		current_index = carousel_items.size() - 1
	
	$WindowContainer/BackwardButton.disabled = true
	change_level_name($WindowContainer/NextWindow/NextLevelName)
	change_level_info($WindowDialog/Content)
	animate_buttons()
	set_configuration_level($WindowContainer/NextWindow/NStar1,$WindowContainer/NextWindow/NStar2,$WindowContainer/NextWindow/NStar3)
	$AnimationPlayer.play("Slide Window Forward")
	yield(get_tree().create_timer(1.0), "timeout")
	$WindowContainer/BackwardButton.disabled = false

func _on_ForwardButton_pressed():
	current_index += 1
	if current_index >= carousel_items.size():
		current_index = 0
	
	$WindowContainer/ForwardButton.disabled = true
	change_level_name($WindowContainer/PreviousWindow/PreviousLevelName)
	change_level_info($WindowDialog/Content)
	animate_buttons()
	set_configuration_level($WindowContainer/PreviousWindow/PStar1,$WindowContainer/PreviousWindow/PStar2,$WindowContainer/PreviousWindow/PStar3)
	$AnimationPlayer.play("Slide Window Backward")
	yield(get_tree().create_timer(1.0), "timeout")
	$WindowContainer/ForwardButton.disabled = false

func _on_InfoButton_pressed():
	show_dialog()

func _on_PlayButton_pressed():
	if current_index == 0:
		get_tree().change_scene("res://Level1.tscn")
	elif current_index == 1:
		get_tree().change_scene("res://Level2.tscn")
	elif current_index == 2:
		get_tree().change_scene("res://Level3.tscn")
	elif current_index == 3:
		pass

func show_dialog():
	#PERSONALIZAR
	$WindowContainer.hide()
	$WindowDialog.popup()

func hide_dialog():
	$WindowDialog.hide()
	$WindowContainer.show()

func _on_CloseButton_pressed():
	self.visible = false
	emit_signal("main_menu")

func _on_AcceptButton_pressed():
	hide_dialog()

func _on_WindowDialog_hide():
	hide_dialog()
