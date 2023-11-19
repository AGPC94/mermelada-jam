extends Node

@onready var player = $Player
@onready var pause_menu = $Pause


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu.show()
		get_tree().paused = true
