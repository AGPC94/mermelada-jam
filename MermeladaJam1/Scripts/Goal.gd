extends Area2D

signal level_complete

var is_open : bool

@onready var open_door_audio = $OpenDoorAudio
@onready var potion_audio = $PotionAudio
@onready var sucess_audio = $SuccessAudio
@onready var door_sprite = $AnimatedSprite2D


func open_door():
	potion_audio.play()
	await get_tree().create_timer(0.01).timeout
	if  get_tree().get_nodes_in_group("Potion").size() == 0:
		is_open = true
		door_sprite.play("open")
		open_door_audio.play()
		sucess_audio.play()


func _on_body_entered(body):
	if body.is_in_group("Player") and is_open:
		level_complete.emit()
