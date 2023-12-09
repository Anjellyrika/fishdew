extends Node

@onready var center_x: int = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
@onready var center_y: int = ProjectSettings.get_setting("display/window/size/viewport_height") / 2

@onready var ground_type: Array
@onready var water_type: Array
@onready var fish_caught: int = 0
@onready var treasure_inventory: int = 0

@onready var unlocked_maps: Array = ["River", "Ocean", "Lava"]

const FISHLIST = [["perch", "carp", "bass"], ["bluetang", "clownfish"], ["karsfish", "lavashark"]]

enum maps {
	River,
	Ocean,
	Lava,
}

func _ready():
	ground_type = ["0acb99", "eed580", "605654"]
	water_type = ["00c1f8", "4590db", "b64636"]
