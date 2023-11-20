class_name InitialDoor
extends AnimatedSprite2D


func open():
	$OpenDoor.play()
	play()

func close():
	$CloseDoor.play()
	play_backwards()
