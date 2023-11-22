class_name Fish

extends Area2D

enum {
	Wait,
	Move,
	Reposition,
}

signal fish_progress_increased
signal fish_progress_decreased

@onready var fish_size = $FishCollision

# Movement bounds
var top_bounds: float
var bot_bounds: float

# Movement variables
var speed_bounds
var target_position: Vector2

var state = Wait

@onready var root = get_owner()
@onready var waitTimer = $WaitControl/Timer

func _ready():
	get_owner().ready.connect(set_start_position)
	target_position = position


func set_start_position():
	top_bounds = root.top_bounds
	bot_bounds = root.bot_bounds
	position = Vector2(root.rod_x, randf_range(top_bounds, bot_bounds))


func get_new_target():
	var max_distance = [global_position.y - top_bounds, bot_bounds - global_position.y]
	var target_y_down = clamp(global_position.y + randf_range(50, max_distance.pick_random()), top_bounds, bot_bounds)
	var target_y_up = clamp(global_position.y - randf_range(50, max_distance.pick_random()), top_bounds, bot_bounds)
	target_position = Vector2(root.rod_x, [target_y_down, target_y_up].pick_random())


func _process(delta):
	print(state)
	speed_bounds = root.fish_speed
	match state:
		Wait:
			wait()
		Move:
			global_position = global_position.lerp(target_position, delta * speed_bounds.pick_random())
			if is_at_target_position():
				state = Reposition
		Reposition:
				get_new_target()
				state = Wait


func wait():
	if waitTimer.time_left == 0:
		waitTimer.start(0.75)
		state = randi_range(0,1)


func is_at_target_position():
	var tolerance = fish_size.shape.height
	return abs(global_position.y - target_position.y) < tolerance


func _on_body_entered(body):
	if body.get_name() == "Bobber":
		fish_progress_increased.emit()


func _on_body_exited(body):
	if body.get_name() == "Bobber":
		fish_progress_decreased.emit()
