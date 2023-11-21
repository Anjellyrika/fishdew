class_name Chest

extends Area2D

signal chest_progress_increased
signal chest_progress_decreased
signal collected

@export var chest_progress: ChestProgress

func _ready():
	chest_progress.progressbar_filled.connect(on_chest_collected)


func _on_body_entered(body):
	if body.get_name() == "Bobber":
		chest_progress_increased.emit()


func _on_body_exited(body):
	if body.get_name() == "Bobber":
		chest_progress_decreased.emit()


func on_chest_collected():
	collected.emit()
