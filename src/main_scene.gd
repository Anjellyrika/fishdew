extends Control

#@onready var actors: Node2D = $ActorLayer/Player
@onready var hud: Control = $HUDLayer/HUD
@onready var collection: VFlowContainer = $HUDLayer/HUD/Collection
@onready var level_bg: ColorRect = $LevelBG
@onready var camera: Camera2D = $Camera2D

var level_instance: Node2D

func _ready():
	collection.get_node("FishCount").set_text("Fish caught: %d" % Global.fish_caught)
	collection.get_node("TreasureCount").set_text("Treasure: %d" % Global.treasure_inventory)

func unload_level():
	if is_instance_valid(level_instance):
		camera.zoom = Vector2(1.5,1.5)
		level_instance.queue_free()
	level_instance = null


func load_fish_level():
	unload_level()
	var level_resource = load("res://src/fishing_lvl/fishing_lvl.tscn")
	camera.zoom = Vector2(1,1)
	if level_resource:
		level_instance = level_resource.instantiate()
		add_child(level_instance)


func _on_start_btn_pressed():
	load_fish_level()
	hud.visible = false
	level_bg.visible = true
