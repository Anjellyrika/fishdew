extends Node

@onready var fishingrod_node = get_parent().get_node("./FishingRod")
@onready var top_edge: Vector2 = fishingrod_node.get_child(1).get_position()
@onready var bottom_edge: Vector2 = fishingrod_node.get_child(2).get_position()
@onready var edge_width = fishingrod_node.get_child(1).shape.size.y

var chest = preload("res://src/chest.tscn").instantiate()
enum {
	NonExistent,
	Spawning,
	Spawned,
	Collected
}
var state = NonExistent
var rand_num: int

func _ready():
	pass

func _process(_delta):
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
			pass
		Collected:
			pass

func _on_timer_timeout():
	if state == NonExistent:
		state = Spawning
