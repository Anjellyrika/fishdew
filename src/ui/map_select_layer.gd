extends CanvasLayer

var main_scene: OverworldScene

@onready var map_select_buttons = $ColorRect/MapSelection.get_children()

@onready var buy_ocean_dialog = $ColorRect/BuyOceanDialog
@onready var buy_lava_dialog = $ColorRect/BuyLavaDialog

func _ready():
	check_unlocked_maps()
	render_buttons()
	

func render_buttons():
	for button in map_select_buttons:
		if button.get_name() in Global.unlocked_maps:
			button.disabled = false


func check_unlocked_maps():
	var highest_unlocked = Global.unlocked_maps.size()
	if highest_unlocked == 3:
		return
	
	var next_map = Global.maps.keys()[highest_unlocked]
	for fish in FishGuide.FISH_IDS[highest_unlocked-1]:
		if FishGuide.fish_stocks[fish] == 0:
			return;
	if next_map not in Global.unlocked_maps:
		Global.unlocked_maps.append(next_map)


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


func _on_buy_ocean_button_pressed():
	if "Ocean" in Global.unlocked_maps:
		buy_ocean_dialog.get_child(0).text = "You've already unlocked this!"
	elif Global.treasure_inventory >= 5:
		Global.unlocked_maps.append("Ocean")
		Global.treasure_inventory -= 5
		render_buttons()
	else:
		buy_ocean_dialog.get_child(0).text = "Not enough treasure!"


func _on_buy_lava_button_pressed():
	if "Lava" in Global.unlocked_maps:
		buy_lava_dialog.get_child(0).text = "You've already unlocked this!"
	elif Global.treasure_inventory >= 10:
		Global.unlocked_maps.append("Lava")
		Global.treasure_inventory -= 10
		render_buttons()
	else:
		buy_lava_dialog.get_child(0).text = "Not enough treasure!"


func _on_buy_ocean_button_mouse_entered():
	buy_ocean_dialog.visible = true


func _on_buy_lava_button_mouse_entered():
	buy_lava_dialog.visible = true


func _on_buy_ocean_button_mouse_exited():
	buy_ocean_dialog.visible = false


func _on_buy_lava_button_mouse_exited():
	buy_lava_dialog.visible = false
