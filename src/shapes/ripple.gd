extends Node2D

var start_position: Vector2
var target_position: Vector2
var target_vector = Vector2(0,-3)
var moving = true
var timer_interval = 1

@onready var root = get_owner()

func _ready():
	start_position = Vector2(Global.center_x, Global.center_y + 360)
	target_position = start_position + target_vector
	position = start_position


func _draw():
	draw_set_transform(Vector2.ZERO, 0, Vector2(1.5,0.5))
	draw_circle(Vector2.ZERO,32.0,Color("6DDFFF"))


func set_move_back():
	target_vector *= -1
	target_position = position + target_vector


func wait():
	if root.state == 1:
		timer_interval = 0.25
	moving = false
	await get_tree().create_timer(timer_interval).timeout
	moving = true


func _process(delta):
	if moving:
		position = position.move_toward(target_position, 1.0)
		if position == target_position:
			set_move_back()
			wait()
