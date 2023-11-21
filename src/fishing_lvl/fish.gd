class_name Fish

extends Area2D

signal fish_progress_increased
signal fish_progress_decreased

@export var speed_bounds: Array

var top_bounds: float
var bot_bounds: float
var rod_x: float
#var start_position: Vector2
var target_position: Vector2
var target_vector: Vector2
var edge_collision: bool = false
var moving: bool = true

@onready var root = get_owner()
@onready var waitTimer = $WaitControl/Timer

func _ready():
	target_position = global_position
	get_owner().ready.connect(set_start_position)


func set_start_position():
	top_bounds = root.rod_top_pos.y + root.edge_width
	bot_bounds = root.rod_bot_pos.y - root.edge_width
	rod_x = root.rod_top_pos.x
	self.position = Vector2(rod_x, randf_range(top_bounds, bot_bounds))


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
	target_position = self.position + target_vector


func _process(delta):
	if not moving:
		wait()
	if moving:
		global_position = global_position.move_toward(target_position, (10*randi_range(speed_bounds[0],speed_bounds[1])) * delta)
		if is_at_target_position() or edge_collision:
			get_new_target(edge_collision)
			edge_collision = false
			wait()


func wait():
	if waitTimer.time_left == 0:
		waitTimer.start(1)
		moving = randi_range(0,1)


func _on_body_entered(body):
	if body.get_name() == "Bobber":
		fish_progress_increased.emit()
	elif body.get_name() == "FishingRod":
		edge_collision = true	


func _on_body_exited(body):
	if body.get_name() == "Bobber":
		fish_progress_decreased.emit()
