extends Node2D

@export var chest_spawner: ChestSpawner

var treasure = 0

@onready var rod_x = $FishingRod/TopEdge.position.x

# Called when the node enters the scene tree for the first time.
func _ready():
	chest_spawner.treasure_collected.connect(add_treasure)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_treasure():
	treasure += 1
