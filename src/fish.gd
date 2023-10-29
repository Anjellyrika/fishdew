extends Area2D

var start_position: Vector2
var target_position: Vector2
var target_vector: Vector2

var edge_collision: bool = false
var moving: bool = true
@onready var waitTimer = $WaitControl/Timer

func _ready():
	start_position = global_position
	target_position = global_position

func is_at_target_position():
	return target_position == global_position

func get_new_target(reverse: bool):
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
	if not moving:
		wait()
	if moving:
		global_position = global_position.move_toward(target_position, randf_range(50.0,100.0) * delta)
		if is_at_target_position() or edge_collision:
			get_new_target(edge_collision)
			edge_collision = false
			wait()

func _on_body_entered(body):
	if body.get_name() != "Bobber":
		edge_collision = true

func wait():
	if waitTimer.time_left == 0:
		waitTimer.start(1)
		moving = randi_range(0,1)
