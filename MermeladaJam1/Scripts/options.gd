extends PanelContainer


signal return_pressed

var master_bus = AudioServer.get_bus_index("Master")
var ambient_bus = AudioServer.get_bus_index("Ambient")
var sf_bus = AudioServer.get_bus_index("Sound Effects")
var music_bus = AudioServer.get_bus_index("Music")

@onready var master_slider = $VBoxContainer/GridContainer/MasterSlider


func _process(_delta: float) -> void:
	if visible and Input.is_action_just_pressed("ui_cancel"):
		return_pressed.emit()


func _on_master_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value/10))


func _on_sf_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(ambient_bus, linear_to_db(value/10))
	AudioServer.set_bus_volume_db(sf_bus, linear_to_db(value/10))


func _on_music_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value/10))


func _on_return_pressed() -> void:
	return_pressed.emit()


func _on_visibility_changed() -> void:
	if visible:
		master_slider.grab_focus()
