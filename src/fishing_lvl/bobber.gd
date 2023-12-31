extends CharacterBody2D

const VELOCITY: float = -30.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var top_bounds
var bot_bounds

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("up"):
		velocity.y += VELOCITY

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * 0.4
