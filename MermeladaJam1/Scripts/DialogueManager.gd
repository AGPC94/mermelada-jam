extends Node

signal dialog_complete

var content = null
var current = 0

@export var dialogue: Dialogue
@export var doctor_sprite: Texture2D
@export var becaria_sprite: Texture2D

func _ready() -> void:
	load_initial()
	show_current_dialog()


func load_initial() -> void:
	var resource = FileAccess.open("res://Dialogs/initial_dialog.json", FileAccess.READ)
	if resource:
		content = JSON.parse_string(resource.get_as_text())


func show_current_dialog():
	var current_dialog = content[current]
	var character = "Dr. Kitten" if current_dialog["character"] == 0 else "Becaria"
	var dialog_content = current_dialog["dialog"]
	var image = doctor_sprite if current_dialog["character"] == 0 else becaria_sprite
	var place = Dialogue.ImagePlace.LEFT if current_dialog["character"] == 0 else Dialogue.ImagePlace.RIGHT

	dialogue.show_dialog(character, dialog_content, image, place)

func _on_dialog_complete() -> void:
	if current < content.size() - 1:
		current += 1
		show_current_dialog()
	else:
		dialogue.hide()
		dialog_complete.emit()
