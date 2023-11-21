extends ProgressBar

signal fish_lost
signal fish_caught

@export var fish: Fish
@export var progress_rate = -10

func _ready():
	value = max_value/2
	fish.fish_progress_increased.connect(increase_score)
	fish.fish_progress_decreased.connect(decrease_score)
	increase_score()
	decrease_score()

func increase_score():
	progress_rate = abs(progress_rate)
	
func decrease_score():
	progress_rate = -1*progress_rate

func _process(delta):
	value += progress_rate * delta
	if value == min_value:
		fish_lost.emit()
	elif value == max_value:
		fish_caught.emit()
