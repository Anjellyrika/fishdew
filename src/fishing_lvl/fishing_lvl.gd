extends Node2D

signal treasure_added

@export var chest_spawner: ChestSpawner

var treasure_count = 0
var top_bounds: float
var bot_bounds: float
var rod_x: float

@onready var rod_top_pos = $FishingRod/TopEdge.position
@onready var rod_bot_pos = $FishingRod/BottomEdge.position
@onready var edge_width = $FishingRod/TopEdge.shape.size.y

# Called when the node enters the scene tree for the first time.
func _ready():
	chest_spawner.chest_collected.connect(add_treasure)
	top_bounds = rod_top_pos.y + edge_width
	bot_bounds = rod_bot_pos.y - edge_width
	rod_x = rod_top_pos.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_treasure():
	treasure_count += 1


func _on_progress_bar_fish_caught():
	Global.fish_caught += 1
	Global.treasure_inventory += treasure_count
