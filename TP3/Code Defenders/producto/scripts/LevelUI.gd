extends CanvasLayer

signal pause

export var music_name: String
export var author_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseButton.set_position(Vector2(1784, -104))
	$MusicName.text = music_name
	$AuthorName.text = "by" + author_name
	$AnimationPlayer.play("Present Song")
	$AnimationPlayer.queue("Enable Pause Button")

func _on_PauseButton_pressed():
	emit_signal("pause")
	
func game_over():
	$AnimationPlayer.play("Game Over")
