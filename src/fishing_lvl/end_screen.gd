extends Control

var active_fish
@onready var root = get_owner()
@onready var fish_caught_sprite: Sprite2D = $EndScreenElements/VBox/Container/FishCaughtSprite
@onready var outcome_display: Label = $EndScreenElements/VBox/Outcome
@onready var treasure_score_display: Label = $EndScreenElements/VBox/TreasureCollected

func _ready():
	active_fish = root.level_properties.species

func display_score(outcome: String):
	var treasure_score = root.treasure_count
	if outcome == "caught":
		fish_caught_sprite.texture = load((FishGuide.fish_resources[active_fish])).sprite
		outcome_display.text = "You " + outcome + " a " + active_fish + "!"
		treasure_score_display.text = "Treasure collected: " + str(treasure_score)
	elif outcome == "lost":
		outcome_display.text = "You " + outcome + " the fish!"
		treasure_score_display.text = ""


func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_exit_pressed():
	get_tree().quit()


func _on_progress_bar_fish_caught():
	self.visible = true
	get_tree().paused = true
	display_score("caught")


func _on_progress_bar_fish_lost():
	self.visible = true
	get_tree().paused = true
	$WilhelmScream.play(0.82)
	display_score("lost")
