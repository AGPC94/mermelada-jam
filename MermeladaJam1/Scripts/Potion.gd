extends Area2D

@export var goal: Node

func _on_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
		goal.open_door()
