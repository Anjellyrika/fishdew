extends ProgressBar

class_name TreasureProgress

@export var chest: Chest
@export var progress_rate = -50

signal treasureCollected

func _ready():
	value = 0
	chest.treasureProgressUp.connect(increase_score)
	chest.treasureProgressDown.connect(decrease_score)
	increase_score()
	decrease_score()

func increase_score():
	progress_rate = abs(progress_rate)

func decrease_score():
	progress_rate = -1*progress_rate

func _process(delta):
	value += progress_rate * delta
	if value == max_value:
		treasureCollected.emit()
