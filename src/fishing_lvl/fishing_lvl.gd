extends Node2D

@export var chest_spawner: ChestSpawner
@export var fish: Fish

var treasure = 0

@onready var rod_top_pos = $FishingRod/TopEdge.position
@onready var rod_bot_pos = $FishingRod/BottomEdge.position
@onready var edge_width = $FishingRod/TopEdge.shape.size.y

# Called when the node enters the scene tree for the first time.
func _ready():
	chest_spawner.treasure_collected.connect(add_treasure)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_treasure():
	treasure += 1
