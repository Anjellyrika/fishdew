extends Control

func display_score(outcome, treasureScore):
	$MarginContainer/VBoxContainer/Outcome.text = "You" + outcome + "the fish!"
	$MarginContainer/VBoxContainer/TreasureCollected.text = "Treasure collected: " + str(treasureScore)

func _on_play_again_pressed():
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().quit()
	
func _on_progress_bar_win():
	self.visible = true
	display_score("caught", 0)
	
func _on_progress_bar_lose():
	self.visible = true
	display_score("lost", 0)


