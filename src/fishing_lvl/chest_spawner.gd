class_name ChestSpawner

extends Node

enum {
	NonExistent,
	Spawning,
	Spawned,
	Collected
}

var state = NonExistent
var rand_num: int

@onready var root = get_owner()
@onready var top_bounds
@onready var bot_bounds

func _ready():
	var edge_width
	var top_edge
	var bot_edge
	for child in root.find_child("FishingRod").get_children():
		var child_name = child.get_name()
		if child_name == "TopEdge":
			top_edge = child.get_position()
			edge_width = child.shape.size.y
		elif child_name == "BottomEdge":
			bot_edge = child.get_position()
	
	top_bounds = top_edge.y + edge_width
	bot_bounds = bot_edge.y - edge_width

func _process(_delta):
	var chest = preload("res://src/fishing_lvl/chest.tscn").instantiate()
	match state:
		NonExistent:
			pass
		Spawning: # attempt to spawn a chest
			rand_num = randi_range(1,8)
			if rand_num == 1:
				chest.position = Vector2(root.rod_x, randf_range(top_bounds, bot_bounds))
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
