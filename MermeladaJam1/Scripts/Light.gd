extends Node2D

@export var player: CharacterBody2D
@export var light: bool = true

@onready var shadow = $LightMask/PlayerShadow
@onready var emision = $Emision

var show_shadow = false

func _ready() -> void:
	emision.visible = light

func _process(delta: float) -> void:
	if show_shadow:
		shadow.global_position = Vector2(player.global_position.x, player.global_position.y)

		var direction = Input.get_axis("left", "right")
		if direction == 0:
			shadow.pause()
		else:
			shadow.play("walk")
			shadow.flip_h = direction < 0


func toggle() -> void:
	emision.visible = not emision.visible


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and emision.visible:
		show_shadow = true
		shadow.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and emision.visible:
		show_shadow = false
		shadow.hide()
