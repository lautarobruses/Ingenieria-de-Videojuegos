extends CanvasLayer

export var music_name: String
export var author_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$MusicName.text = music_name
	$AuthorName.text = "by" + author_name
	$AnimationPlayer.play("Present Song")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
