extends Area2D

class_name Chest

@export var treasure_bar: TreasureProgress

signal treasureProgressUp
signal treasureProgressDown

func _ready():
	treasure_bar.treasureCollected.connect(despawn)

func _on_body_entered(body):
	if body.get_name() == "Bobber":
		treasureProgressUp.emit()

func _on_body_exited(body):
	if body.get_name() == "Bobber":
		treasureProgressDown.emit()

func despawn():
	queue_free()
