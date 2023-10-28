extends Area2D

@export var move_speed: float = 50.0
var move_direction = Vector2(0, 50.0)

var start_position: Vector2
var target_position: Vector2

func _ready():
	start_position = global_position
	target_position = start_position + move_direction

func is_at_target_position():
	return target_position == global_position

func get_new_target_position():
	# TODO: implement bounds accdg to fishing rod edges
	var target_vector = Vector2(0, randf_range(-300.0, 300.0))
	target_position = start_position + target_vector

func _process(delta):
	global_position = global_position.move_toward(target_position, move_speed * delta)
	if is_at_target_position():
		get_new_target_position()
		if global_position == start_position:
			target_position = start_position + move_direction
