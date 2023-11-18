extends Sprite2D

@export var shadow_distance = 500
@export var player: CharacterBody2D
@export var shadow: Sprite2D

var show_shadow = false

func _process(delta: float) -> void:
	if show_shadow:
		var player_shadow = Vector2(player.global_position.x, global_position.y + shadow_distance)
		var direction = global_position.direction_to(player_shadow)
		var shew_angle = Vector2.DOWN.angle_to(direction)
		
		shadow.global_position.x = player_shadow.x
		shadow.position.y = shadow_distance - abs(shew_angle) * 12
		shadow.skew = shew_angle


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		show_shadow = true
		shadow.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		show_shadow = false
		shadow.hide()
