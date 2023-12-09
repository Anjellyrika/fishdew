extends CanvasLayer

class_name FishCollection

var sprite_texture
var fish_label

@onready var stocks: Dictionary
@onready var grid = $ColorRect/VBoxContainer.get_children()

func _ready():
	stocks = FishGuide.fish_stocks
	for row in grid:
		if row.get_class() == "HBoxContainer":
			for fish in row.get_children():
				sprite_texture = fish.get_child(0)
				fish_label = fish.get_child(1)
				set_shader(false)
				if stocks[fish.get_name()] == 0:
					set_shader(true)
					fish_label.text = "???"


func set_shader(val: bool):
	sprite_texture.material.set_shader_parameter("locked", val)
