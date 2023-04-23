extends KinematicBody2D

const COLOR_COMPONENT_1 = "233705"
const COLOR_COMPONENT_2 = "25121f"
const COLOR_COMPONENT_3 = "bd3629"
const COLOR_COMPONENT_4 = "c1791d"
const COLOR_COMPONENT_5 = "ffff81"
const COLOR_COMPONENT_6 = "ff59ff"
const SHIP_COMPONENTS = [1,2,3,4,5,6]

export (int) var energy

var current_configuration = [] #Controla las mecanicas del escudo
var color_configuration = [] #Controla los colores del escudo
var is_animated = false
var is_hitted = false

func _ready():
	current_configuration = [1,2,5]
	color_configuration = [1,2,5]
#	init_configuration(3)
	pass

func _physics_process(_delta):
	if is_hitted:
		$AnimationPlayer.play("hitted")
		
		yield(get_tree().create_timer(2.0), "timeout")
		is_hitted = false
	else:
		if !color_configuration.empty():
			$Sprite.visible = true
			if !is_animated:
				animate()
		else:
			$Sprite.visible = false

func init_configuration(N):
	current_configuration.clear()
	var aux_components = SHIP_COMPONENTS
	# Mezclo los elementos del array
	aux_components.shuffle() 
	# Selecciona los N elementos del array mezclado
	for i in range(N):
		current_configuration.append(aux_components[i])

func animate():
	var current_color = color_configuration.pop_front()
		
	if current_color == 1:
		$AnimationPlayer.play("color_comp1")
	elif current_color == 2:
		$AnimationPlayer.play("color_comp2")
	elif current_color == 3:
		$AnimationPlayer.play("color_comp3")
	elif current_color == 4:
		$AnimationPlayer.play("color_comp4")
	elif current_color == 5:
		$AnimationPlayer.play("color_comp5")
	elif current_color == 6:
		$AnimationPlayer.play("color_comp6")
	
	is_animated = true
	yield(get_tree().create_timer(5.0), "timeout")
	is_animated = false
	
	color_configuration.append(current_color)

func enable():
	$CollisionPolygon2D.set_deferred("disabled", false)
	
func disable():
	$CollisionPolygon2D.set_deferred("disabled", false)

func calculate_damage(same_configuration):
	if same_configuration:
		energy -= 1
		$ShieldHitted.play()
		is_hitted = true
	else:
		$ProjectileReflected.play()

func special_hitted(configuration):
	var same_configuration = true
	
	if !configuration.empty():
		for component in configuration:
			if !current_configuration.has(component):
				same_configuration = false
		
		calculate_damage(same_configuration)	
