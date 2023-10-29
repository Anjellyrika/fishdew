extends Area2D

var move_speed: float = 50.0

var start_position: Vector2
var target_position: Vector2
var target_vector: Vector2

var edge_collision: bool = false

func _ready():
	start_position = global_position
	target_position = start_position

func is_at_target_position():
	return target_position == global_position

func get_new_target(reverse: bool):
	move_speed = randf_range(50.0, 150.0)
	var max_move = 500.0
	if reverse:
		if target_vector.y < 0:
			target_vector = Vector2(0, randf_range(0, max_move))
		else:
			target_vector = Vector2(0, randf_range(-1*max_move, 0))
	else:
		target_vector = Vector2(0, randf_range(-1*max_move, max_move))
	target_position = start_position + target_vector

func _process(delta):
	wait()
	global_position = global_position.move_toward(target_position, move_speed * delta)
	if is_at_target_position() or edge_collision:
		get_new_target(edge_collision)
		edge_collision = false

func _on_body_entered(body):
	if body.get_name() != "Bobber":
		edge_collision = true

func wait():
	pass
