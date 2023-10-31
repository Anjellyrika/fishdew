extends Area2D

class_name Chest

signal treasureProgressUp
signal treasureProgressDown

func _on_body_entered(body):
	if body.get_name() == "Bobber":
		print("score up")
		treasureProgressUp.emit()

func _on_body_exited(body):
	if body.get_name() == "Bobber":
		treasureProgressDown.emit()
