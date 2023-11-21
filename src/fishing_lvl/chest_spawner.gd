class_name ChestSpawner

extends Node

signal treasure_collected

enum {
	NonExistent,
	Spawning,
	Spawned,
	Collected
}

var state = NonExistent
var rand_num: int

@onready var root = get_owner()

func _ready():
	pass

func _process(_delta):
	var chest = preload("res://src/fishing_lvl/chest.tscn").instantiate()
	match state:
		NonExistent:
			pass
		Spawning: # attempt to spawn a chest
			rand_num = randi_range(1,8)
			if rand_num == 1:
				chest.position = Vector2(root.rod_x, randf_range(root.top_bounds, root.bot_bounds))
				add_child(chest)
				state = Spawned
		Spawned:
			if get_child_count() == 2:
				state = Collected
		Collected:
			treasure_collected.emit()
			state = NonExistent


func _on_timer_timeout():
	if state == NonExistent:
		state = Spawning
