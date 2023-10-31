extends Node

@onready var top_edge: Vector2 = get_parent().get_node("./FishingRod").get_child(1).get_position()
@onready var bottom_edge: Vector2 = get_parent().get_node("./FishingRod").get_child(2).get_position()

var chest_node = preload("res://src/chest.tscn")
var isChestSpawned = false
var rand_num: int

func _process(_delta):
	if isChestSpawned:
		print("chest on map")
		pass

func _on_timer_timeout():
	# attempt to spawn a chest
	if not isChestSpawned:
		rand_num = randi_range(1,1)
		if rand_num == 1:
			var chest = chest_node.instantiate()
			chest.position = Vector2(top_edge.x, randi_range(100,500))
			add_child(chest)
			isChestSpawned = true
