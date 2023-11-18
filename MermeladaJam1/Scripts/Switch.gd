extends Area2D

@export var lights: Array[Node2D] = []

@onready var switch_audio = $SwitchAudio

var is_active = false

func _ready() -> void:
	Events.interact_element.connect(self._on_interact)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.show_interaction()
		is_active = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.hide_interaction()
		is_active = false

func _on_interact() -> void:
	if is_active:
		switch_audio.play()

		for light in lights:
			light.visible = not light.visible
