extends Node

const SAVE_PATH = "res://persistencia"

var saveDict = {
		"PuntajeNivel1" : 0,
		"PuntajeNivel2" : 0,
		"PuntajeNivel3" : 0,
		"PuntajeNivel4" : 0
	}


func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		print("No se encontro el archivo")
		return
	save_game.open(SAVE_PATH, File.READ)
	saveDict = parse_json(save_game.get_line())
	save_game.close()

func save_game():
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	save_game.store_line(to_json(saveDict))
	save_game.close()

func setNivelUno(puntaje):
	if (puntaje > saveDict["PuntajeNivel1"]):
		saveDict["PuntajeNivel1"]=puntaje

func setNivelDos(puntaje):
	if(puntaje > saveDict["PuntajeNivel2"]):
		saveDict["PuntajeNivel2"]=puntaje

func setNivelTres(puntaje):
	if(puntaje > saveDict["PuntajeNivel3"]):
		saveDict["PuntajeNivel3"]=puntaje

func setNivelCuatro(puntaje):
	if(puntaje > saveDict["PuntajeNivel4"]):
		saveDict["PuntajeNivel4"]=puntaje
	
func getPuntajeNivelUno():
	return saveDict["PuntajeNivel1"]
	
func getPuntajeNivelDos():
	return saveDict["PuntajeNivel2"]

func getPuntajeNivelTres():
	return saveDict["PuntajeNivel3"]
	
func getPuntajeNivelCuatro():
	return saveDict["PuntajeNivel4"]
