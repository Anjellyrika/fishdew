extends Node

@onready var center_x: int = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
@onready var center_y: int = ProjectSettings.get_setting("display/window/size/viewport_height") / 2

@onready var fish_caught: int = 0
@onready var treasure_inventory: int = 0

@onready var unlocked_maps: Array = ["River"]

const FISHLIST = [["perch", "carp", "bass"], ["bluetang", "clownfish"], ["karsfish", "lavashark"]]

enum maps {
	River,
	Ocean,
	Lava,
}

func _ready():
	var ground_colors = ["0acb99", "eed580", "605654"]
	var water_colors = ["00c1f8", "4590db", "b64636"]
