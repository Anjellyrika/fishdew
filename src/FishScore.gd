extends ProgressBar

signal Lose
signal Win

@export var fish: Fish
@export var progress_rate = -10

func _ready():
	value = max_value/2
	fish.scoreIncrease.connect(increase_score)
	fish.scoreDecrease.connect(decrease_score)
	increase_score()
	decrease_score()

func increase_score():
	progress_rate = abs(progress_rate)
	
func decrease_score():
	progress_rate = -1*progress_rate

func _process(delta):
	value += progress_rate * delta
	if value == min_value:
		Lose.emit()
	elif value == max_value:
		Win.emit()
