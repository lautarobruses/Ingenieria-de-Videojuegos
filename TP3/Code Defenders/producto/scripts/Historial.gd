extends Node2D


var palabra1 = [0,0,0,0,0,0,0,0]
var palabra2 = [0,0,0,0,0,0,0,0]
var palabra3 = [0,0,0,0,0,0,0,0]

enum TipoNave {
	UNO,
	DOS,
	TRES,
	CUATRO,
	CINCO,
	SEIS,
}

func setGolpe(palabra):
	
	if (palabra1[0]==0):
		palabra1=palabra.duplicate()
		seteaPalabra(palabra,1)
	elif(palabra2[0]==0):
		palabra2 = palabra.duplicate()
		seteaPalabra(palabra,2)
	else:
		palabra3 = palabra.duplicate()
		seteaPalabra(palabra,3)

func seteaPalabra(palabra,NroDePalabra):
	var i=0
	if (NroDePalabra==1):
		while(i<8 and palabra[i]!=0):
			seteaNodoPalabra1(i,buscaTipo(palabra[i]))
			i+=1
	elif(NroDePalabra==2):
		while(i<8 and palabra[i]!=0):
			seteaNodoPalabra2(i,buscaTipo(palabra[i]))
			i+=1
	else:
		while(i<8 and palabra[i]!=0):
			seteaNodoPalabra3(i,buscaTipo(palabra[i]))
			i+=1

func seteaNodoPalabra1(j,tipo):
	match j:
		0:
			$palabra1/slot.agregaSimbolo(tipo)
			continue
		1:
			$palabra1/slot2.agregaSimbolo(tipo)
			continue
		2:
			$palabra1/slot3.agregaSimbolo(tipo)
			continue
		3:
			$palabra1/slot4.agregaSimbolo(tipo)
			continue
		4:
			$palabra1/slot5.agregaSimbolo(tipo)
			continue
		5:
			$palabra1/slot6.agregaSimbolo(tipo)
			continue
		6:
			$palabra1/slot7.agregaSimbolo(tipo)
			continue
		7:
			$palabra1/slot8.agregaSimbolo(tipo)
			continue
			
func seteaNodoPalabra2(j,tipo):
	match j:
		0:
			$palabra2/slot.agregaSimbolo(tipo)
			continue
		1:
			$palabra2/slot2.agregaSimbolo(tipo)
			continue
		2:
			$palabra2/slot3.agregaSimbolo(tipo)
			continue
		3:
			$palabra2/slot4.agregaSimbolo(tipo)
			continue
		4:
			$palabra2/slot5.agregaSimbolo(tipo)
			continue
		5:
			$palabra2/slot6.agregaSimbolo(tipo)
			continue
		6:
			$palabra2/slot7.agregaSimbolo(tipo)
			continue
		7:
			$palabra2/slot8.agregaSimbolo(tipo)
			continue

func seteaNodoPalabra3(j,tipo):
	match j:
		0:
			$palabra3/slot.agregaSimbolo(tipo)
			continue
		1:
			$palabra3/slot2.agregaSimbolo(tipo)
			continue
		2:
			$palabra3/slot3.agregaSimbolo(tipo)
			continue
		3:
			$palabra3/slot4.agregaSimbolo(tipo)
			continue
		4:
			$palabra3/slot5.agregaSimbolo(tipo)
			continue
		5:
			$palabra3/slot6.agregaSimbolo(tipo)
			continue
		6:
			$palabra3/slot7.agregaSimbolo(tipo)
			continue
		7:
			$palabra3/slot8.agregaSimbolo(tipo)
			continue


func buscaTipo(nroNave):
	match nroNave:
		1:
			return TipoNave.UNO
		2:
			return TipoNave.DOS
		3:
			return TipoNave.TRES
		4:
			return TipoNave.CUATRO
		5:
			return TipoNave.CINCO
		6:
			return TipoNave.SEIS
