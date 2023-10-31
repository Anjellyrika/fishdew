extends Area2D

class_name Chest

signal treasureProgressUp
signal treasureProgressDown

func _on_body_entered(body):
	if body.get_name() == "Bobber":
		treasureProgressUp.emit()

func _on_body_exited(body):
	if body.get_name() == "Bobber":
		treasureProgressDown.emit()
