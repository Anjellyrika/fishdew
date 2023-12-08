extends Node2D

signal treasure_added

@export var chest_spawner: ChestSpawner

var treasure_count = 0

var top_bounds: float
var bot_bounds: float
var rod_x: float

# Set game properties
var fish_speed
var chest_spawn_rate

# Set movement bounds
@onready var rod_top_y = $FishingRod/TopEdge.global_position.y
@onready var rod_bot_y = $FishingRod/BottomEdge.global_position.y
@onready var edge_width = $FishingRod/TopEdge.shape.size.y

# Called when the node enters the scene tree for the first time.
func _ready():
	chest_spawner.chest_collected.connect(add_treasure)
	chest_spawner.powerup_collected.connect(activate_powerup)
	top_bounds = rod_top_y + edge_width
	bot_bounds = rod_bot_y - edge_width
	rod_x = ProjectSettings.get_setting("display/window/size/window_width_override") / 2
	
	chest_spawn_rate = [4,8,12].pick_random() # lower is better
	fish_speed = [[200,400], [600,700], [700,800]].pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_treasure():
	treasure_count += 1


func activate_powerup(): # Powerup freezes the fish for 3 seconds
	var temp = fish_speed
	fish_speed = [0,0]
	await get_tree().create_timer(3).timeout
	fish_speed = temp
	


func _on_progress_bar_fish_caught():
	Global.fish_caught += 1
	Global.treasure_inventory += treasure_count
