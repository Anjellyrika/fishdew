extends Node

@onready var fishingrod_node = get_parent().get_node("./FishingRod")
@onready var top_edge: Vector2 = fishingrod_node.get_child(1).get_position()
@onready var bottom_edge: Vector2 = fishingrod_node.get_child(2).get_position()
@onready var edge_width = fishingrod_node.get_child(1).shape.size.y

var chest_node = preload("res://src/chest.tscn")
var isChestSpawned = false
var rand_num: int

func _process(_delta):
	if isChestSpawned:
		pass

func _on_timer_timeout():
	# attempt to spawn a chest
	if not isChestSpawned:
		rand_num = randi_range(1,4)
		if rand_num == 1:
			var chest = chest_node.instantiate()
			chest.position = Vector2(top_edge.x, randf_range(top_edge.y + edge_width, bottom_edge.y - edge_width))
			add_child(chest)
			isChestSpawned = true
