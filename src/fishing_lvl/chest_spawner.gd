class_name ChestSpawner

extends Node

enum {
	NonExistent,
	Spawning,
	Spawned,
	Powerup_Spawned,
}

signal chest_collected
signal powerup_collected

var state = NonExistent
var offscreen_position: Vector2

@onready var root = get_owner()
@onready var x_pos = ProjectSettings.get_setting("display/window/size/window_width_override") / 2
@onready var chest = $Chest
@onready var powerup = $Powerup

func _ready():
	offscreen_position = chest.position
	chest.collected.connect(despawn)
	powerup.collected.connect(despawn)

func _process(_delta):
	match state:
		NonExistent:
			pass
		Spawning: # attempt to spawn a chest
			if randi_range(1, root.chest_spawn_rate) == 1:
				if randi_range(1, root.chest_spawn_rate) == 1:
					powerup.position = Vector2(x_pos, randi_range(root.top_bounds, root.bot_bounds))
					state = Powerup_Spawned
				else:
					chest.position = Vector2(x_pos, randi_range(root.top_bounds, root.bot_bounds))
					state = Spawned
		Spawned:
			pass


func _on_timer_timeout():if state == NonExistent:
		state = Spawning


func despawn():
	if state == Spawned:
		chest.position = offscreen_position
		chest_collected.emit()
	if state == Powerup_Spawned:
		powerup.position = offscreen_position
		powerup_collected.emit()
	state = NonExistent
