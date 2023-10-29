extends ProgressBar

@export var fish: Fish
@export var bobber: Bobber
@export var progress_rate = -10

func _ready():
	value = max_value/2
	fish.scoreIncrease.connect(increase_score)
	bobber.scoreDecrease.connect(decrease_score)
	increase_score()
	decrease_score()

func increase_score():
	progress_rate = abs(progress_rate)
	
func decrease_score():
	progress_rate = -1*progress_rate

func _process(delta):
	value += progress_rate * delta
