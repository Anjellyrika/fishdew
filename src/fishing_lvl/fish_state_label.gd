extends Label

@export var fish: Area2D
@export var timer: Timer

func _process(_delta):
	text = "moving: " + str(fish.moving) + ". " + "timer: " + str(timer.time_left)
