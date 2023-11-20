extends TextureRect

@export_range(0.1, 5) var animation: float = 1
@export_range(1, 10) var wait: float = 2

var show = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	$Text.modulate = Color.TRANSPARENT
	tween.tween_property(self, "modulate", Color.WHITE, animation).set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Text, "modulate", Color.WHITE, animation).set_trans(Tween.TRANS_QUAD)
	tween.tween_interval(wait)
	tween.tween_callback(self._show_label)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Label.visible and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _show_label():
	$Label.show()
