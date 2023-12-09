extends CanvasLayer

var main_scene: OverworldScene

@onready var buttons = $ColorRect/MapSelection.get_children()

func _ready():
	for button in buttons:
		if button.get_name() in Global.unlocked_maps:
			button.disabled = false

func load_overworld():
	var overworld_resource = load("res://src/overworld/main_scene.tscn")
	if overworld_resource:
		main_scene = overworld_resource.instantiate()
		get_tree().get_root().add_child(main_scene)
		get_tree().current_scene = main_scene
		queue_free()


func _on_river_pressed():
	Global.active_map = "River"
	load_overworld()


func _on_ocean_pressed():
	Global.active_map = "Ocean"
	load_overworld()


func _on_lava_pressed():
	Global.active_map = "Lava"
	load_overworld()
