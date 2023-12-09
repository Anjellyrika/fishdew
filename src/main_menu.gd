extends Control

@onready var help = $HelpLayer
@onready var maps = $MapSelectLayer

func _on_help_pressed():
	help.visible = true


func _on_play_pressed():
	maps.visible = true


func _on_exit_help_pressed():
	help.visible = false


func _on_exit_pressed():
	get_tree().quit()
