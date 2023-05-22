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
