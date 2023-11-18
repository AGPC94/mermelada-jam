extends Node2D

@export var player: CharacterBody2D

@export_range(0, 10, 0.1) var blink_time : float = 1.0
@export_range(0, 10) var blinks : int = 4
@export_range(0, 10, 0.1) var wait_time : float = 1.0

enum State { BLINKING, WAITING }
var current_blinks := 0

var state := State.BLINKING

func _ready() -> void:
	$Light.player = player
	$Timer.start(blink_time)


func _on_timer_timeout() -> void:
	var wait = blink_time

	if state == State.BLINKING:
		$Light.visible = not $Light.visible
		current_blinks += 1
		
		if current_blinks >= blinks:
			current_blinks = 0
			wait = wait_time
			state = State.WAITING
	else:
		state = State.BLINKING

	$Timer.start(wait)
