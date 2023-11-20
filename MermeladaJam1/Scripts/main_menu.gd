extends TextureRect

@export var main_menu_background: Texture2D
@export var options_background: Texture2D

@onready var potion = $Potion
@onready var options_rect = $ColorRect
@onready var options = $ColorRect/Options

var option = 0

func _process(_delta: float) -> void:
	if not options_rect.visible:
		if option > 0 and Input.is_action_just_pressed("ui_up"):
			option -= 1
			_update_options()
		elif option < 2 and Input.is_action_just_pressed("ui_down"):
			option += 1
			_update_options()

		if Input.is_action_just_pressed("ui_accept"):
			if option == 0:
				get_tree().change_scene_to_file("res://Scenes/game.tscn")
			elif option == 1:
				texture = options_background
				options_rect.show()
				options.show()
				potion.hide()
			elif option == 2:
				get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _update_options():
	if not options_rect.visible:
		if option > -1:
			potion.show()
			potion.position.y = 660 + 110 * option
		else:
			potion.hide()


func _on_options_return_pressed() -> void:
	texture = main_menu_background
	options_rect.hide()
	options.hide()
	potion.show()


func _on_play_mouse_entered() -> void:
	option = 0
	_update_options()


func _on_options_mouse_entered() -> void:
	option = 1
	_update_options()


func _on_credits_mouse_entered() -> void:
	option = 2
	_update_options()


func _on_mouse_exited() -> void:
	option = -1
	_update_options()
