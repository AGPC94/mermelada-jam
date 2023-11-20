extends ColorRect

var enabled = false
var main_menu = true
var option = 0

@export var player: CharacterBody2D
@export var reset_position: Vector2

@onready var potion1 = $PanelContainer/MainMenu/GridContainer/Potion1
@onready var potion2 = $PanelContainer/MainMenu/GridContainer/Potion2
@onready var potion3 = $PanelContainer/MainMenu/GridContainer/Potion3
@onready var potion4 = $PanelContainer/MainMenu/GridContainer/Potion4
@onready var timer = $Timer


func _process(_delta: float) -> void:
	if not enabled and timer.is_stopped():
		$Timer.start()
	elif enabled and Input.is_action_just_pressed("pause"):
		_resume()

	if main_menu:
		if option > 0 and Input.is_action_just_pressed("ui_up"):
			option -= 1
			_update_options()
		elif option < 3 and Input.is_action_just_pressed("ui_down"):
			option += 1
			_update_options()

		if Input.is_action_just_pressed("ui_accept"):
			if option == 0:
				_resume()
			elif option == 1:
				_restart()
			elif option == 2:
				main_menu = false
				$PanelContainer.hide()
				$Options.show()
			elif option == 3:
				get_tree().quit()


func _update_options():
	if option == -1:
		potion1.modulate = Color.TRANSPARENT
		potion2.modulate = Color.TRANSPARENT
		potion3.modulate = Color.TRANSPARENT
		potion4.modulate = Color.TRANSPARENT
	elif option == 0:
		potion1.modulate = Color.WHITE
		potion2.modulate = Color.TRANSPARENT
		potion3.modulate = Color.TRANSPARENT
		potion4.modulate = Color.TRANSPARENT
	elif option == 1:
		potion1.modulate = Color.TRANSPARENT
		potion2.modulate = Color.WHITE
		potion3.modulate = Color.TRANSPARENT
		potion4.modulate = Color.TRANSPARENT
	elif option == 2:
		potion1.modulate = Color.TRANSPARENT
		potion2.modulate = Color.TRANSPARENT
		potion3.modulate = Color.WHITE
		potion4.modulate = Color.TRANSPARENT
	elif option == 3:
		potion1.modulate = Color.TRANSPARENT
		potion2.modulate = Color.TRANSPARENT
		potion3.modulate = Color.TRANSPARENT
		potion4.modulate = Color.WHITE


func _restart():
	player.global_position = Vector2(reset_position)
	_resume()


func _resume():
	enabled = false
	main_menu = true
	option = 0
	_update_options()
	$PanelContainer.show()
	$Options.hide()
	hide()
	get_tree().paused = false


func _on_timeout() -> void:
	enabled = true


func _on_options_return_pressed() -> void:
	main_menu = true
	$PanelContainer.show()
	$Options.hide()


func _on_continue_mouse_entered() -> void:
	option = 0
	_update_options()


func _on_restart_mouse_entered() -> void:
	option = 1
	_update_options()


func _on_options_mouse_entered() -> void:
	option = 2
	_update_options()


func _on_quit_game_mouse_entered() -> void:
	option = 3
	_update_options()


func _on_mouse_exited() -> void:
	option = -1
	_update_options()
