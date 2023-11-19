class_name Dialogue
extends Control

signal dialog_complete

@export_range(0, 1) var character_velocity: float = 0.01
@export var left_character_color: Color
@export var right_character_color: Color

var delta_time = 0
var content: String = ""
var content_pos: int
var place: ImagePlace

enum ImagePlace { LEFT, RIGHT }

func _process(delta: float) -> void:
	if content_pos < content.length():
		delta_time += delta
		if delta_time > character_velocity:
			_update_content()

		if Input.is_action_just_pressed("interact"):
			content_pos = content.length()
			$PanelContainer/VBoxContainer/Content.text = content

	elif Input.is_action_just_pressed("interact"):
		dialog_complete.emit()

func show_dialog(character: String, dialog: String, image: Texture2D, image_place: ImagePlace) -> void:
	show()
	$PanelContainer.show()
	$PanelContainer/VBoxContainer/Name.text = character
	$PanelContainer/VBoxContainer/Content.text = ""
	content = dialog
	content_pos = 0
	place = image_place

	match place:
		ImagePlace.LEFT:
			$PanelContainer/VBoxContainer/Name.add_theme_color_override("font_color", left_character_color)
			$LeftImage.texture = image
			$LeftImage.show()
			$RightImage.hide()
		ImagePlace.RIGHT:
			$PanelContainer/VBoxContainer/Name.add_theme_color_override("font_color", right_character_color)
			$RightImage.texture = image
			$RightImage.show()
			$LeftImage.hide()

func _update_content() -> void:
	content_pos += 1
	if content_pos < content.length():
		while content[content_pos] == "[":
			var pos = content.find("]", content_pos)
			if pos > -1:
				content_pos = pos + 1
			else:
				break
	$PanelContainer/VBoxContainer/Content.text = content.substr(0, content_pos)
