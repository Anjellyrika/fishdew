class_name ChestSpawner

extends Node

enum {
	NonExistent,
	Spawning,
	Spawned
}

signal chest_collected

var state = NonExistent
var offscreen_position: Vector2

@onready var root = get_owner()
@onready var chest = $Chest

func _ready():
	offscreen_position = chest.position
	chest.collected.connect(despawn)

func _process(_delta):
	match state:
		NonExistent:
			pass
		Spawning: # attempt to spawn a chest
			if randi_range(1, root.chest_spawn_rate) == 1:
				chest.position = Vector2(root.rod_x, randf_range(root.top_bounds, root.bot_bounds))
				state = Spawned
		Spawned:
			pass


func _on_timer_timeout():
	if state == NonExistent:
		state = Spawning


func despawn():
	chest.position = offscreen_position
	chest_collected.emit()
	state = NonExistent
