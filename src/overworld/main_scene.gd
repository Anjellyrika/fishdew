extends Control

class_name OverworldScene

@export var active_map: String

@onready var ground: ColorRect = $OverworldLayer/Ground
@onready var water: ColorRect = $OverworldLayer/Water
@onready var hud: Control = $HUDLayer/HUD
@onready var collection: VFlowContainer = $HUDLayer/HUD/Collection
@onready var level_bg: ColorRect = $LevelBG
@onready var camera: Camera2D = $OverworldLayer/Camera2D
@onready var state_label: Label = $HUDLayer/HUD/StateLabel/Label
@onready var start_btn: Button = $HUDLayer/HUD/StateLabel/StartBtn

enum {
	Waiting,
	Bite,
	InGame,
}

var state = Waiting
var level_instance: Node2D
var map_select_instance: CanvasLayer

func _ready():
	start_btn.visible = false
	collection.get_node("FishCount").set_text("Fish caught: %d" % Global.fish_caught)
	collection.get_node("TreasureCount").set_text("Treasure: %d" % Global.treasure_inventory)
	
	# Recolor the map
	var map = Global.maps[active_map]
	ground.color = Global.ground_type[map]
	water.color = Global.water_type[map]

func unload_level():
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null
	state = Waiting


func load_fish_level():
	unload_level()
	var level_resource = load("res://src/fishing_lvl/fishing_lvl.tscn")
	if level_resource:
		level_instance = level_resource.instantiate()
		add_child(level_instance)


func _process(delta):
	match state:
		Waiting:
			state_label.text = "Waiting for fish..."
		Bite:
			state_label.text = "Got one!!"
			start_btn.visible = true
		InGame:
			pass


func _on_timer_timeout():
	if state == Waiting:
		if randi_range(0, 1) == 0:
			$ActorLayer/FishBite.play()
			state = Bite

func _on_start_btn_pressed():
	load_fish_level()
	hud.visible = false
	level_bg.visible = true
	state = InGame


func _on_menu_pressed():
	pass

func _on_maps_pressed():
	var map_select_resource = load("res://src/ui/map_select_layer.tscn")
	if map_select_resource:
		map_select_instance = map_select_resource.instantiate()
		map_select_instance.visible = true
		queue_free()
		get_parent().add_child(map_select_instance)
