extends Node2D

var puntajeTotal = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var naveEsbirro = preload("res://EsbirroNivelTres.tscn")
var rng = RandomNumberGenerator.new()

enum TipoNave {
	UNO,
	DOS,
	TRES,
	CUATRO,
	CINCO,
	SEIS,
}

func seteaBarra():
	for i in 8:
		if(i%2==0):
			$Barra.seteaNodo(i,TipoNave.UNO)
		else:
			$Barra.seteaNodo(i,TipoNave.DOS)

# Called when the node enters the scene tree for the first time.
func _ready():
	seteaBarra()
	set_player()
	$AnimationPlayer.play("main")
	pass # Replace with function body.


func enviaGrupoEnemigos():
	var posicion
	var tipo
	randomize()
	for j in 8:
		posicion=100
		for i in 10:
			tipo = rng.randi_range(1,6)
			var nuevoEnemigo = naveEsbirro.instance()
			nuevoEnemigo.position = Vector2(2000, posicion)
			nuevoEnemigo.setTipoNave(tipo)
			add_child(nuevoEnemigo)
			posicion += 100
			randomize()
		yield(get_tree().create_timer(1.0), "timeout")
	pass # Replace with function body.
	
	
func set_player():
	$Player.start()
	#$HealthBar.start()

func set_music(song):
	$Music.stream = song
	$Music.play()

func game_over(): #gestionar game over de victoria
	puntajeTotal -= (110 - $Player.health)
	print(puntajeTotal)
	get_tree().quit()

func sumaPuntaje(puntaje):
	puntajeTotal+=puntaje
