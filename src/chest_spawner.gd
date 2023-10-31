extends Node

var chest_node = preload("res://src/chest.tscn")
var isChestSpawned = false
var rand_num: int

func _process(delta):
	if isChestSpawned:
		print("chest on map")
		pass

func _on_timer_timeout():
	# attempt to spawn a chest
	if not isChestSpawned:
		rand_num = randi_range(1,4)
		if rand_num == 1:
			var chest = chest_node.instantiate()
			chest.position = Vector2(randi_range(100,500), randi_range(100,500))
			add_child(chest)
			isChestSpawned = true
