extends Node

var content = null
var current = 0
var waiting = false


@export var textures : Array[Texture2D] = []


func _ready() -> void:
	var resource = FileAccess.open("res://Dialogs/final_dialog.json", FileAccess.READ)
	if resource:
		content = JSON.parse_string(resource.get_as_text())
		show_current_transition()

func show_current_transition() -> void:
	var dialog = content[current]

	if dialog.has("texture"):
		match dialog["transition"]:
			"in":
				$Background.texture = textures[dialog["texture"]]
				$Background.modulate = Color.BLACK

				var tween = get_tree().create_tween()
				tween.tween_property($Background, "modulate", Color.WHITE, dialog["time"]).set_trans(Tween.TRANS_QUAD)
				if current > 0:
					show_current_dialog()
				else:
					tween.tween_callback(self.show_current_dialog)
			"out-in":
				waiting = true
				show_current_dialog()
				var tween = get_tree().create_tween()
				tween.tween_property($Background, "modulate", Color.BLACK, dialog["time"]).set_trans(Tween.TRANS_QUAD)
				tween.tween_callback(func():
					$Background.texture = textures[dialog["texture"]]
					$Background.modulate = Color.BLACK)
				tween.tween_property($Background, "modulate", Color.WHITE, dialog["time"]).set_trans(Tween.TRANS_QUAD)
				tween.tween_callback(func(): waiting = false)
	else:
		show_current_dialog()


func show_current_dialog() -> void:
	var current_dialog = content[current]
	var character = "Dr. Kitten" if current_dialog["character"] == 0 else "Becaria"
	var dialog_content = current_dialog["dialog"]
	var place = Dialogue.ImagePlace.LEFT if current_dialog["character"] == 0 else Dialogue.ImagePlace.RIGHT

	$Dialogue.show_dialog(character, dialog_content, null, place)


func _on_dialog_complete() -> void:
	if not waiting:
		if current < content.size() - 1:
			current += 1
			show_current_transition()
		else:
			get_tree().change_scene_to_file("res://Scenes/credits.tscn")
