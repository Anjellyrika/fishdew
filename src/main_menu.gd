extends Control

@onready var help = $HelpLayer
@onready var maps = $MapSelectLayer
@onready var buttons = $MapSelectLayer/ColorRect/MapSelection.get_children()

func _ready():
	for button in buttons:
		if button.get_name() in Global.unlocked_maps:
			button.disabled = false

func _on_help_pressed():
	help.visible = true


func _on_play_pressed():
	maps.visible = true
#	get_tree().change_scene_to_file("res://src/overworld/main_scene.tscn")


func _on_exit_help_pressed():
	help.visible = false


func _on_exit_pressed():
	get_tree().quit()
