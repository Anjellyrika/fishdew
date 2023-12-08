extends Node

@onready var fish_caught: int = 0
@onready var treasure_inventory: int = 0

@onready var center_x: int = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
@onready var center_y: int = ProjectSettings.get_setting("display/window/size/viewport_height") / 2

func _ready():
	pass
