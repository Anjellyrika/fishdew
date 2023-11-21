extends Area2D

class_name Chest

@export var treasure_bar: TreasureProgress

signal chest_progress_increased
signal chest_progress_decreased

func _ready():
	treasure_bar.treasure_collected.connect(despawn)

func _on_body_entered(body):
	if body.get_name() == "Bobber":
		chest_progress_increased.emit()

func _on_body_exited(body):
	if body.get_name() == "Bobber":
		chest_progress_decreased.emit()

func despawn():
	queue_free()
