extends Node

class_name ChestSpawner

@onready var fishingrod_node = get_parent().get_node("./FishingRod")
@onready var top_edge
@onready var bottom_edge
@onready var edge_width

enum {
	NonExistent,
	Spawning,
	Spawned,
	Collected
}
var state = NonExistent
var rand_num: int

var treasureCollected = 0

func _ready():
#	pass
	for child in fishingrod_node.get_children():
		var child_name = child.get_name()
		if child_name == "top edge":
			top_edge = child.get_position()
			edge_width = child.shape.size.y
		elif child_name == "bottom edge":
			bottom_edge = child.get_position()

func _process(_delta):
	var chest = preload("res://src/chest.tscn").instantiate()
	match state:
		NonExistent:
			pass
		Spawning: # attempt to spawn a chest
			rand_num = randi_range(1,8)
			if rand_num == 1:
				chest.position = Vector2(top_edge.x, randf_range(top_edge.y + edge_width, bottom_edge.y - edge_width))
				add_child(chest)
				state = Spawned
		Spawned:
			if get_child_count() == 2:
				state = Collected
		Collected:
			treasureCollected += 1
			state = NonExistent

func _on_timer_timeout():
	if state == NonExistent:
		state = Spawning
