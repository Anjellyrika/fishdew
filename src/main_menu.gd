extends Control

@onready var help = $HelpLayer

func _on_help_pressed():
	help.visible = true


func _on_play_pressed():
	get_tree().change_scene_to_file("res://src/ui/map_select_layer.tscn")


func _on_exit_help_pressed():
	help.visible = false


func _on_exit_pressed():
	get_tree().quit()
