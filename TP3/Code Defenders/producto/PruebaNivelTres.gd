extends "res://scripts/Level.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var naveEsbirro = preload("res://EsbirroNivelTres.tscn")
var rng = RandomNumberGenerator.new()
var palabra1 = [0,0,0,0,0,0,0,0]
var palabra2 = [0,0,0,0,0,0,0,0]
var palabra3 = [0,0,0,0,0,0,0,0]
var palabra4 = [0,0,0,0,0,0,0,0]
var palabra = 0

enum TipoNave {
	UNO,
	DOS,
	TRES,
	CUATRO,
	CINCO,
	SEIS,
}

func armoCodigo():
	palabra1=[1,2,3,4,5,6,2,1]
	palabra2=[4,3,5,4,5,6,6,1]
	palabra3=[6,5,4,1,4,3,1,3]
	palabra4=[5,5,5,4,4,2,6,2]

func seteaBarra():
	palabra += 1
	match palabra:
		1:
			for i in 8:
				guardaNodo(i,palabra1[i])
			continue
		2:
			for i in 8:
				guardaNodo(i,palabra2[i])
			continue
		3:
			for i in 8:
				guardaNodo(i,palabra3[i])
			continue
		4:
			for i in 8:
				guardaNodo(i,palabra4[i])
			continue
	yield(get_tree().create_timer(1.0), "timeout")
	enviaGrupoEnemigos()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_player()
	armoCodigo()
	$AnimationPlayer.play("main")
	pass # Replace with function body.


func enviaGrupoEnemigos():
	var posicion
	var tipo
	var esCorrecto
	randomize()
	var filaResultado = rng.randi_range(1,9)
	for j in 8:
		posicion=150
		for i in 9:
			if(i==filaResultado):
				esCorrecto = true
				if(palabra==1):
					tipo = palabra1[j]
				elif(palabra==2):
					tipo = palabra2[j]
				elif(palabra==3):
					tipo=palabra3[j]
				else:
					tipo = palabra4[j]
			else:
				esCorrecto = false
				tipo = rng.randi_range(1,6)
			var nuevoEnemigo = naveEsbirro.instance()
			nuevoEnemigo.position = Vector2(2000, posicion)
			nuevoEnemigo.SetEsCorrecto(esCorrecto)
			nuevoEnemigo.setTipoNave(tipo)
			add_child(nuevoEnemigo)
			posicion += 100
			randomize()
		yield(get_tree().create_timer(1.0), "timeout")
	pass # Replace with function body.
	
func guardaNodo(nodo,tipo):
	match tipo:
		1:
			$Barra.seteaNodo(nodo,TipoNave.UNO)
		2:
			$Barra.seteaNodo(nodo,TipoNave.DOS)
		3:
			$Barra.seteaNodo(nodo,TipoNave.TRES)
		4:
			$Barra.seteaNodo(nodo,TipoNave.CUATRO)
		5:
			$Barra.seteaNodo(nodo,TipoNave.CINCO)
		6:
			$Barra.seteaNodo(nodo,TipoNave.SEIS)
