class_name Fish

extends CharacterBody2D

enum {
	Wait,
	Move,
	Reposition,
}

signal fish_progress_increased
signal fish_progress_decreased

@onready var fish_size = $FishArea/FishCollision
@onready var sprite = $FishArea/Icon

# Movement bounds
var rod_x: int
var top_bounds: int
var bot_bounds: int

# Movement variables
var speed_bounds: Array
var direction: Vector2
const ACCEL: float = 2.0 
var target_position: Vector2

var state = Move

@onready var root = get_owner()
@onready var waitTimer = $WaitControl/Timer

func _ready():
	get_owner().ready.connect(set_start_position)
	target_position = global_position
	sprite.material.set_shader_parameter("frozen", false)


func set_start_position():
	top_bounds = floor(root.top_bounds)
	bot_bounds = ceil(root.bot_bounds)
	rod_x = root.rod_x
	global_position = Vector2(rod_x, randi_range(top_bounds, bot_bounds))
	target_position = global_position


func get_new_target():
	target_position = Vector2(rod_x, randi_range(top_bounds, bot_bounds))
	direction = global_position.direction_to(target_position)


func _physics_process(delta):
	speed_bounds = root.fish_speed
	set_shader(speed_bounds)
	match state:
		Wait:
			wait()
		Move:
			velocity = velocity.lerp(direction * speed_bounds.pick_random(), delta * ACCEL)
			if is_at_target_position():
				velocity = velocity.lerp(Vector2.ZERO, delta * ACCEL)
				state = Reposition
		Reposition:
			get_new_target()
			state = Wait
	move_and_slide()


func wait():
	if waitTimer.time_left == 0:
		waitTimer.start(root.idle_time)
		state = randi_range(0,1)


func is_at_target_position():
	var tolerance = 100
	return abs(global_position.y - target_position.y) < tolerance


func set_shader(current_speed):
	if current_speed == [0,0]:
		sprite.material.set_shader_parameter("frozen", true)
	else:
		sprite.material.set_shader_parameter("frozen", false)


func _on_fish_area_body_entered(body):
	if body.get_name() == "Bobber":
		fish_progress_increased.emit()


func _on_fish_area_body_exited(body):
	if body.get_name() == "Bobber":
		fish_progress_decreased.emit()
