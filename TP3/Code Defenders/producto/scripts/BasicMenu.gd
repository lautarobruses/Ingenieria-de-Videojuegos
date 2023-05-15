extends Control

signal main_menu()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_BackButton_pressed():
	self.visible = false
	emit_signal("main_menu")
