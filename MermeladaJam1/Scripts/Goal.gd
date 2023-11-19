extends Area2D

var is_open : bool

@onready var potion_audio = $PotionAudio
@onready var door_sprite = $AnimatedSprite2D

func open_door():
	potion_audio.play()
	await get_tree().create_timer(0.01).timeout
	if  get_tree().get_nodes_in_group("Potion").size() == 0:
		print_debug("No hay pociones, se abre la puerta")
		is_open = true
		door_sprite.play("open")
	else:
		print_debug("Aún hay pociones, la puerta está cerrada")


func _on_body_entered(body):
	if body.is_in_group("Player") and is_open:
		print_debug("Pasa al siguiente nivel")
