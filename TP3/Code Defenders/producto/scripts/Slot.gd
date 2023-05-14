extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var default_tex = preload("res://assets/img/Barra y slot/item_slot_default_background.png")
var default_style: StyleBoxTexture = null

var texturaNaveUno = preload("res://assets/img/TexturasPrueba/NaveUno_FlatStyle.tres")
var texturaNaveDos = preload("res://assets/img/TexturasPrueba/NaveDos_FlatStyle.tres")
var texturaNaveTres = preload("res://assets/img/TexturasPrueba/Tes_Style.tres")
var texturaNaveCuatro = preload("res://assets/img/TexturasPrueba/NaveCuatro_FlatStyle.tres")
var texturaNaveCinco = preload("res://assets/img/TexturasPrueba/NaveCinco_FlatStyle.tres")
var texturaNaveSeis = preload("res://assets/img/TexturasPrueba/NaveSeis_FlatStyle.tres")

enum TipoNave {
	UNO,
	DOS,
	TRES,
	CUATRO,
	CINCO,
	SEIS,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	default_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	set('custom_styles/panel', default_style)
	pass # Replace with function body.

func agregaSimbolo(tipo):
	print("meto textura")
	match tipo:
		TipoNave.UNO:
			set('custom_styles/panel', texturaNaveUno)
			continue
		TipoNave.DOS:
			set('custom_styles/panel', texturaNaveDos)
			continue
		TipoNave.TRES:
			set('custom_styles/panel', texturaNaveTres)
			continue
		TipoNave.CUATRO:
			set('custom_styles/panel', texturaNaveCuatro)
			continue
		TipoNave.CINCO:
			set('custom_styles/panel', texturaNaveCinco)
			continue
		TipoNave.SEIS:
			set('custom_styles/panel', texturaNaveSeis)
			continue
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func eliminaSimbolo():
	set('custom_styles/panel', default_style)
