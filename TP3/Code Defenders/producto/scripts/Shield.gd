extends KinematicBody2D

signal broken

onready var historial = get_parent().get_parent().get_node("Historial")

const COLOR_COMPONENT_1 = "233705"
const COLOR_COMPONENT_2 = "25121f"
const COLOR_COMPONENT_3 = "bd3629"
const COLOR_COMPONENT_4 = "c1791d"
const COLOR_COMPONENT_5 = "ffff81"
const COLOR_COMPONENT_6 = "ff59ff"
const SHIP_COMPONENTS = [1,2,3,4,5,6]

export (int) var energy
export (int) var nivel


var current_configuration = [] #Controla las mecanicas del escudo
var color_configuration = [] #Controla los colores del escudo
var is_animated = false
var is_hitted = false
var is_broken = false
var is_over = false

var palabra1 = [0,0,0,0,0,0,0,0]
var palabra2 = [0,0,0,0,0,0,0,0]
var palabra3 = [0,0,0,0,0,0,0,0]

func _ready():
	current_configuration = [1]
	color_configuration = [1,2]
#	init_configuration(3)

func _physics_process(_delta):
	if !is_over:
		if is_hitted:
			$AnimationPlayer.play("hitted")
			
			yield(get_tree().create_timer(2.0), "timeout")
			is_hitted = false
		elif is_broken:
			break_shield()
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
	$CollisionShape2D.set_deferred("disabled", false)
	
func disable():
	$CollisionShape2D.set_deferred("disabled", true)

func calculate_damage():
	energy -= 1
	$ShieldHitted.play()
	is_hitted = true
	
	if (energy == 0):
		is_broken = true

func break_shield():
	is_over = true
	$AnimationPlayer.play("broken")
	disable()
	emit_signal("broken")
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()

func special_condition(configuration):
	var cumpleCondicion = false
	if(nivel==1):  
		cumpleCondicion = esCodigoBloque(configuration)
	elif(nivel==2):  
		cumpleCondicion = esNoSingular(configuration)
	elif(nivel==3):
		pass
	else:
		pass
	
	if cumpleCondicion:
		historial.setGolpe(configuration)
		calculate_damage()
	else:
		$ProjectileReflected.play()
		pass

func esCodigoBloque(configuration):
	var salida = false
	if !configuration.empty():
		for comp in configuration:
			if (comp==1 or comp==2 or comp==3):
				salida = true
	return salida

func esNoSingular(configuration):
	var salida = false
	if(palabra1[0]==0):
		salida = true
		palabra1 = configuration.duplicate()
	elif(palabra2==[0]):
		if(configuration!=palabra1):
			salida = true
			palabra2 = configuration.duplicate()
	elif (palabra3[0]==0):
		if(configuration!=palabra1 and configuration!=palabra2):
			salida = true
			palabra2 = configuration.duplicate()
	return salida

func esUnivocamenteDecodificable(configuration):
	var salida = false
	
	if(esCodigoBloque(configuration)):
		if(palabra1[0]==0):
			salida = true
			palabra1 = configuration.duplicate()
		elif(palabra2==[0]):
			if(configuration!=palabra1):
				salida = true
				palabra2 = configuration.duplicate()
		elif (palabra3[0]==0):
			if(configuration!=palabra1 and configuration!=palabra2):
				salida = true
				palabra2 = configuration.duplicate()
		return salida
