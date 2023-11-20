extends Node

signal dialog_complete

var content = null
var current = 0

@export var dialogue: Dialogue
@export var left_image: Texture2D
@export var right_image: Texture2D
@export var initial_door: InitialDoor

func _ready() -> void:
	load_initial()
	show_current_dialog()


func load_initial() -> void:
	var resource = FileAccess.open("res://Dialogs/initial_dialog.json", FileAccess.READ)
	if resource:
		content = JSON.parse_string(resource.get_as_text())
		initial_door.open()


func show_current_dialog():
	var current_dialog = content[current]
	var character = "Dr. Kitten" if current_dialog["character"] == 0 else "Becaria"
	var dialog_content = current_dialog["dialog"]
	var place = Dialogue.ImagePlace.LEFT if current_dialog["character"] == 0 else Dialogue.ImagePlace.RIGHT
	var image = left_image if current_dialog["character"] == 0 else right_image

	dialogue.show_dialog(character, dialog_content, image, place)


func _on_dialog_complete() -> void:
	if current < content.size() - 1:
		current += 1
		show_current_dialog()
	else:
		content = null
		current = 0
		dialogue.hide()
		dialog_complete.emit()
		initial_door.close()
