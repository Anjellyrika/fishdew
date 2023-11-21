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

@onready var root = get_owner()

func _ready():
	pass


func _process(_delta):
	match state:
		NonExistent:
			pass
		Spawning: # attempt to spawn a chest
			if randi_range(1,8) == 1:
				var chest = preload("res://src/fishing_lvl/chest.tscn").instantiate()
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
