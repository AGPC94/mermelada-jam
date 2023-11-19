extends ColorRect

var enabled = false
var main_menu = true
var option = 0


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
		elif option < 2 and Input.is_action_just_pressed("ui_down"):
			option += 1
			_update_options()

		if Input.is_action_just_pressed("ui_accept"):
			if option == 0:
				_resume()
			elif option == 1:
				main_menu = false
				$MainMenu.hide()
				$Options.show()
			elif option == 2:
				get_tree().quit()


func _update_options():
	if option == 0:
		$MainMenu/GridContainer/Potion1.modulate = Color.WHITE
		$MainMenu/GridContainer/Potion2.modulate = Color.TRANSPARENT
		$MainMenu/GridContainer/Potion3.modulate = Color.TRANSPARENT
	elif option == 1:
		$MainMenu/GridContainer/Potion1.modulate = Color.TRANSPARENT
		$MainMenu/GridContainer/Potion2.modulate = Color.WHITE
		$MainMenu/GridContainer/Potion3.modulate = Color.TRANSPARENT
	elif option == 2:
		$MainMenu/GridContainer/Potion1.modulate = Color.TRANSPARENT
		$MainMenu/GridContainer/Potion2.modulate = Color.TRANSPARENT
		$MainMenu/GridContainer/Potion3.modulate = Color.WHITE


func _resume():
	enabled = false
	main_menu = true
	$MainMenu.show()
	$Options.hide()
	hide()
	get_tree().paused = false


func _on_timeout() -> void:
	enabled = true


func _on_options_return_pressed() -> void:
	main_menu = true
	$MainMenu.show()
	$Options.hide()
