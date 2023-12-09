extends Node2D

signal treasure_added

# Set level properties
@export var chest_spawner: ChestSpawner
@export var level_properties: FishStats
var fish_speed: Array 
var idle_time: float
var treasure_rarity: int

var treasure_count = 0

var top_bounds: float
var bot_bounds: float
var rod_x: float

# Set movement bounds
@onready var rod_top_y = $FishingRod/TopEdge.global_position.y
@onready var rod_bot_y = $FishingRod/BottomEdge.global_position.y
@onready var edge_width = $FishingRod/TopEdge.shape.size.y

func _ready():
	chest_spawner.chest_collected.connect(add_treasure)
	chest_spawner.powerup_collected.connect(activate_powerup)
	top_bounds = rod_top_y + edge_width
	bot_bounds = rod_bot_y - edge_width
	rod_x = ProjectSettings.get_setting("display/window/size/window_width_override") / 2
	
	fish_speed = level_properties.speed_range
	idle_time = level_properties.idle_time
	treasure_rarity = level_properties.treasure_spawns


func add_treasure():
	treasure_count += 1


func activate_powerup(): # Powerup freezes the fish for 3 seconds
	var temp = fish_speed
	fish_speed = [0,0]
	await get_tree().create_timer(3).timeout
	fish_speed = temp


func check_unlocked_maps():
	var highest_unlocked = Global.unlocked_maps.size()
	for fish in FishGuide.FISH_IDS[highest_unlocked-1]:
		if FishGuide.fish_stocks[fish] == 0:
			return;
	Global.unlocked_maps.append(Global.maps.keys()[highest_unlocked])


func _on_progress_bar_fish_caught():
	Global.fish_caught += 1
	FishGuide.fish_stocks[level_properties.id] += 1
	Global.treasure_inventory += treasure_count
	check_unlocked_maps()
