extends Control

@onready var root = get_owner()

func _ready():
	pass


func display_score(outcome: String):
	var treasure_score = root.treasure
	$EndScreenElements/VBox/TreasureCollected.text = ""
	$EndScreenElements/VBox/Outcome.text = "You " + outcome + " the fish!"
	if outcome == "caught":
		$EndScreenElements/VBox/TreasureCollected.text = "Treasure collected: " + str(treasure_score)


func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_exit_pressed():
	get_tree().quit()


func _on_progress_bar_win():
	self.visible = true
	get_tree().paused = true
	display_score("caught")


func _on_progress_bar_lose():
	self.visible = true
	get_tree().paused = true
	display_score("lost")
