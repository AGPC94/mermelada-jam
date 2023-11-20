extends Node

@onready var player = $Player
@onready var pause_menu = $Pause


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu.show()
		get_tree().paused = true


func _on_level_complete() -> void:
	get_tree().change_scene_to_file("res://Scenes/ending.tscn")
