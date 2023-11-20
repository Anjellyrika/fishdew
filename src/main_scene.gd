extends Control

@onready var hud: Control = $HUD
@onready var collection: VFlowContainer = $HUD/Collection
@onready var main_buttons: VBoxContainer = $HUD/MainBtns
@onready var camera: Camera2D = $Camera2D

var level_instance: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func unload_level():
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null


func load_fish_level():
	unload_level()
	var level_resource = load("res://src/fishing_lvl/fishing_lvl.tscn")
	if level_resource:
		level_instance = level_resource.instantiate()
		add_child(level_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_btn_pressed():
	load_fish_level()
	hud.visible = false
