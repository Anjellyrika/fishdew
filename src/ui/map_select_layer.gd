extends CanvasLayer

@export var overworld_resource = load("res://src/overworld/main_scene.tscn")
var main_scene: OverworldScene

@onready var buttons = $ColorRect/MapSelection.get_children()

func _ready():
	for button in buttons:
		if button.get_name() in Global.unlocked_maps:
			button.disabled = false

func load_overworld(map: String):
	if overworld_resource:
		main_scene = overworld_resource.instantiate()
		main_scene.active_map = map
		get_tree().get_root().add_child(main_scene)
		get_tree().current_scene = main_scene
		queue_free()


func _on_river_pressed():
	load_overworld("River")


func _on_ocean_pressed():
	load_overworld("Ocean")


func _on_lava_pressed():
	load_overworld("Lava")
