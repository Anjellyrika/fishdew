class_name Fish

extends Area2D

signal fish_progress_increased
signal fish_progress_decreased

@export var speed_bounds: Array #?

var top_bounds: float
var bot_bounds: float
var target_position: Vector2
var target_vector: Vector2
var has_edge_collided: bool = false
var moving: bool = true

@onready var root = get_owner()
@onready var waitTimer = $WaitControl/Timer

func _ready():
	target_position = global_position
	get_owner().ready.connect(set_start_position)


func set_start_position():
	top_bounds = root.top_bounds
	bot_bounds = root.bot_bounds
	position = Vector2(root.rod_x, randf_range(top_bounds, bot_bounds))


func is_at_target_position():
	return target_position == global_position


func get_new_target(reverse_direction: bool):
	var prev_target_vector_y = target_vector.y
	var dist_from_top = position.y - top_bounds
	var dist_from_bot = bot_bounds - position.y
	var distance_array = [dist_from_top, dist_from_bot]
	if reverse_direction:
		if prev_target_vector_y < 0:
			target_vector = Vector2(0, randf_range(0, dist_from_bot))
		else:
			target_vector = Vector2(0, randf_range(-1*dist_from_top, 0))
	else:
		target_vector = Vector2(0, randf_range(0, distance_array.min()))
	target_position = position + target_vector


func _process(delta):
	if not moving:
		wait()
	if moving:
		global_position = global_position.move_toward(target_position, (10*randi_range(speed_bounds[0],speed_bounds[1])) * delta)
		if is_at_target_position() or has_edge_collided:
			get_new_target(has_edge_collided)
			has_edge_collided = false
			wait()


func wait():
	if waitTimer.time_left == 0:
		waitTimer.start(1)
		moving = randi_range(0,1)


func _on_body_entered(body):
	if body.get_name() == "Bobber":
		fish_progress_increased.emit()
	elif body.get_name() == "FishingRod":
		has_edge_collided = true


func _on_body_exited(body):
	if body.get_name() == "Bobber":
		fish_progress_decreased.emit()
