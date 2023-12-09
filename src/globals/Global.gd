extends Node

@onready var center_x: int = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
@onready var center_y: int = ProjectSettings.get_setting("display/window/size/viewport_height") / 2

@onready var ground_type: Dictionary
@onready var water_type: Dictionary
@onready var fish_caught: int = 0
@onready var treasure_inventory: int = 0

@onready var unlocked_maps: Array = ["River"]
@onready var active_map: String


enum maps {
	River,
	Ocean,
	Lava,
}

func _ready():
	ground_type = {"River": "0acb99", "Ocean": "eed580", "Lava": "605654"}
	water_type = {"River": "00c1f8", "Ocean": "4590db", "Lava": "b44720"}
