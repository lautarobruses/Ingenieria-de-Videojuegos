extends Node2D

onready var jugador = get_parent().get_node("Player")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var palabra = [0,0,0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.

enum TipoNave {
	UNO,
	DOS,
	TRES,
	CUATRO,
	CINCO,
	SEIS,
}

func _ready():
	pass # Replace with function body.



func buscaPrimerNodoLibre():
	var j = 0
	var encontre=0
	while(!encontre and j<8):
		if palabra[j]==0:
			encontre = 1
		else:
			j+=1
	return j
	
func borraUltimoSlot():
	var j = 0
	var encontre=1
	while(encontre and j<8):
		if palabra[j]==0:
			encontre = 0
		else:
			j+=1
	if(!encontre):
		palabra[j-1]=0
		eliminaNodo(j-1)
		
func limpiaBarra():
	var j = 0
	while(j<8):
		palabra[j]=0
		eliminaNodo(j)
		j+=1
		
func eliminaNodo(j):
	match j:
		0:
			$GridContainer/Slot1.eliminaSimbolo()
			continue
		1:
			$GridContainer/Slot2.eliminaSimbolo()
			continue
		2:
			$GridContainer/Slot3.eliminaSimbolo()
			continue
		3:
			$GridContainer/Slot4.eliminaSimbolo()
			continue
		4:
			$GridContainer/Slot5.eliminaSimbolo()
			continue
		5:
			$GridContainer/Slot6.eliminaSimbolo()
			continue
		6:
			$GridContainer/Slot7.eliminaSimbolo()
			continue
		7:
			$GridContainer/Slot8.eliminaSimbolo()
			continue	

func seteaNodo(j,tipo):
	match j:
		0:
			$GridContainer/Slot1.agregaSimbolo(tipo)
			continue
		1:
			$GridContainer/Slot2.agregaSimbolo(tipo)
			continue
		2:
			$GridContainer/Slot3.agregaSimbolo(tipo)
			continue
		3:
			$GridContainer/Slot4.agregaSimbolo(tipo)
			continue
		4:
			$GridContainer/Slot5.agregaSimbolo(tipo)
			continue
		5:
			$GridContainer/Slot6.agregaSimbolo(tipo)
			continue
		6:
			$GridContainer/Slot7.agregaSimbolo(tipo)
			continue
		7:
			$GridContainer/Slot8.agregaSimbolo(tipo)
			continue


func _on_ParteNaveUno_levantaSimbolo():
	var j = buscaPrimerNodoLibre()
	if j<8:
		seteaNodo(j,TipoNave.UNO)
		palabra[j]=1
	pass # Replace with function body.

func _on_ParteNaveDos_levantaSimbolo():
	var j = buscaPrimerNodoLibre()
	if j<8:
		seteaNodo(j,TipoNave.DOS)
		palabra[j]=2
	pass # Replace with function body.


func _on_ParteNaveTres_levantaSimbolo():
	var j = buscaPrimerNodoLibre()
	if j<8:
		seteaNodo(j,TipoNave.TRES)
		palabra[j]=3
	pass # Replace with function body.


func _on_ParteNaveCuatro_levantaSimbolo():
	print("busco slot")
	var j = buscaPrimerNodoLibre()
	if j<8:
		seteaNodo(j,TipoNave.CUATRO)
		palabra[j]=4
	pass # Replace with function body.


func _on_ParteNaveCinco_levantaSimbolo():
	var j = buscaPrimerNodoLibre()
	if j<8:
		seteaNodo(j,TipoNave.CINCO)
		palabra[j]=5
	pass # Replace with function body.


func _on_ParteNaveSeis_levantaSimbolo():
	var j = buscaPrimerNodoLibre()
	if j<8:
		seteaNodo(j,TipoNave.SEIS)
		palabra[j]=6
	pass # Replace with function body.


func _on_Player_sueltaPieza():
	borraUltimoSlot()
	pass # Replace with function body.


func _on_Player_disparoEspecial():
	if(palabra[0]!=0):
		jugador.setComponents(palabra)
		limpiaBarra()
	pass # Replace with function body.
