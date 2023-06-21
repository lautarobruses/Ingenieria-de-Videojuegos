extends "res://scripts/Level.gd"

export var song: AudioStream

var naveEsbirro = preload("res://EsbirroNivelTres.tscn")

var rng = RandomNumberGenerator.new()
var palabra1 = [0,0,0,0,0,0,0,0]
var palabra2 = [0,0,0,0,0,0,0,0]
var palabra3 = [0,0,0,0,0,0,0,0]
var palabra4 = [0,0,0,0,0,0,0,0]
var palabra5 = [0,0,0,0,0,0,0,0]
var palabra6 = [0,0,0,0,0,0,0,0]
var palabra7 = [0,0,0,0,0,0,0,0]

var palabra = 0

enum TipoNave {
	UNO,
	DOS,
	TRES,
	CUATRO,
	CINCO,
	SEIS,
}

func _ready():
	randomize()
	start_level()

func start_level():
	set_player()
	armoCodigo()
	set_music(song)
	setNivel(3)
	$Historial.hide()
	$AnimationPlayer.play("main")

func armoCodigo():
	palabra1=[1,2,3,4,5,6,2,1]
	palabra2=[4,3,5,4,5,6,6,1]
	palabra3=[6,5,4,1,4,3,1,3]
	palabra4=[5,5,5,4,4,2,6,2]
	palabra5=[4,5,2,3,1,1,5,2]
	palabra6=[3,2,6,1,3,3,5,5]
	palabra7=[2,1,2,3,6,5,6,5]

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
		5:
			for i in 8:
				guardaNodo(i,palabra5[i])
			continue
		6:
			for i in 8:
				guardaNodo(i,palabra6[i])
			continue
		7:
			for i in 8:
				guardaNodo(i,palabra7[i])
			continue
	yield(get_tree().create_timer(1.0), "timeout")
	enviaGrupoEnemigos()


func enviaGrupoEnemigos():
	var posicion
	var tipo
	var esCorrecto
	randomize()
	var filaResultado = rng.randi_range(1,9)
	for j in 8:
		posicion=200
		for i in 9:
			if(i==filaResultado):
				esCorrecto = true
				tipo = buscaNodo(j)
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

func game_over(): #gestionar game over de victoria
	#Puntaje
	puntajeTotal -= (110 - $Player.health)
	if(puntajeTotal > 200):
		Persistencia.setNivelTres(puntajeTotal)
		Persistencia.save_game()
		#Musica
		$Music.volume_db -= 25
		$Sounds.stream = jingle_win
		$Sounds.play()
		#Musica
		yield(get_tree().create_timer(3.0), "timeout")
		#Menu
		#Seteo El puntaje
		$PauseMenu.show_you_win(3,puntajeTotal)
		$Player.blow()
		yield(get_tree().create_timer(2.0), "timeout")
		$Music.volume_db += 25
	else:
		_on_HealthBar_player_dead()

func buscaNodo(i):
	match palabra:
		1:
			return palabra1[i]
		2:
			return palabra2[i]
		3:
			return palabra3[i]
		4:
			return palabra4[i]
		5:
			return palabra5[i]
		6:
			return palabra6[i]
		7:
			return palabra7[i]
