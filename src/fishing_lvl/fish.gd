class_name Fish

extends Area2D

enum {
	Wait,
	Reposition,
	Move,
}

signal fish_progress_increased
signal fish_progress_decreased

@onready var fish_size = $FishCollision

# Movement bounds
var top_bounds: float
var bot_bounds: float

# Movement variables
var speed_bounds
var direction
var velocity
var target_position: Vector2

var state = Wait

@onready var root = get_owner()
@onready var waitTimer = $WaitControl/Timer

func _ready():
	get_owner().ready.connect(set_start_position)
	target_position = global_position


func set_start_position():
	top_bounds = root.top_bounds
	bot_bounds = root.bot_bounds
	global_position = Vector2(root.rod_x, randf_range(top_bounds, bot_bounds))


func get_new_target():
	target_position = Vector2(root.rod_x, randf_range(top_bounds, bot_bounds))


func _process(delta):
	speed_bounds = 500
	
	match state:
		Wait:
			wait()
		Reposition:
				get_new_target()
				state = Wait
		Move:
			direction = global_position.direction_to(target_position)
			velocity = direction.y * speed_bounds * delta
			global_position += Vector2(0, velocity)
			if is_at_target_position():
				state = Reposition


func wait():
	if waitTimer.time_left == 0:
		waitTimer.start(1)
		state = [0,2].pick_random()


func is_at_target_position():
	var tolerance = fish_size.shape.height
	print("check tolerance ", target_position.y, abs(global_position.y - target_position.y) < tolerance)##
	return abs(global_position.y - target_position.y) < tolerance


func _on_body_entered(body):
	if body.get_name() == "Bobber":
		fish_progress_increased.emit()


func _on_body_exited(body):
	if body.get_name() == "Bobber":
		fish_progress_decreased.emit()
