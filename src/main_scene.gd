extends Control

@onready var hud: Control = $HUDLayer/HUD
@onready var collection: VFlowContainer = $HUDLayer/HUD/Collection
@onready var level_bg: ColorRect = $LevelBG
@onready var camera: Camera2D = $Camera2D
@onready var state_label: Label = $HUDLayer/HUD/StateLabel/Label
@onready var start_btn: Button = $HUDLayer/HUD/StateLabel/StartBtn

enum {
	Waiting,
	Bite,
	InGame,
}

var state = Waiting
var level_instance: Node2D

func _ready():
	start_btn.visible = false
	collection.get_node("FishCount").set_text("Fish caught: %d" % Global.fish_caught)
	collection.get_node("TreasureCount").set_text("Treasure: %d" % Global.treasure_inventory)


func unload_level():
	if is_instance_valid(level_instance):
		camera.zoom = Vector2(1.5,1.5)
		level_instance.queue_free()
	level_instance = null
	state = Waiting


func load_fish_level():
	unload_level()
	var level_resource = load("res://src/fishing_lvl/fishing_lvl.tscn")
	camera.zoom = Vector2(1,1)
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
