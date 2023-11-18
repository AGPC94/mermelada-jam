extends Area2D

var player

func _process(delta):
	if player != null and overlaps_body(player):
		player.hurt(global_position)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player = null
