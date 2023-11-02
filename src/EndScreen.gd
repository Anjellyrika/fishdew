extends Control

@onready var chest_control: ChestSpawner = get_tree().current_scene.get_child(4)

func display_score(outcome, treasureScore):
	treasureScore = chest_control.treasureCollected
	$MarginContainer/VBoxContainer/Outcome.text = "You " + outcome + " the fish!"
	if outcome == "caught":
		$MarginContainer/VBoxContainer/TreasureCollected.text = "Treasure collected: " + str(treasureScore)
	else:
		$MarginContainer/VBoxContainer/TreasureCollected.text = ""

func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().quit()
	
func _on_progress_bar_win():
	self.visible = true
	get_tree().paused = true
	display_score("caught", 0)
	
func _on_progress_bar_lose():
	self.visible = true
	get_tree().paused = true
	display_score("lost", 0)


