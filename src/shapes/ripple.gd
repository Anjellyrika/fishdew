extends Node2D

var start_position = Vector2(286.5,253)
var target_vector = Vector2(0,-3)
var target_position = start_position + target_vector
var moving = true

func _ready():
	position = start_position


func _draw():
	draw_set_transform(start_position, 0, Vector2(1.25,0.5))
	draw_circle(Vector2.ZERO,20.0,Color("6DDFFF"))


func set_move_back():
	target_vector *= -1
	target_position = position + target_vector


func wait():
	moving = false
	await get_tree().create_timer(1).timeout
	moving = true


func _process(delta):
	if moving:
		position = position.move_toward(target_position, 1.0)
		if position == target_position:
			set_move_back()
			wait()
