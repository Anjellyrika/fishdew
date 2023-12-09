extends CharacterBody2D

const JUMP_VELOCITY = -30.0

@onready var animated_sprite = $PlayerSprite
@onready var animator = $AnimationPlayer
@onready var root = get_owner()


func _process(_delta):
	update_animation()


func update_animation():
	match root.state:
		0:
			animated_sprite.play("waiting")
		1:
			animated_sprite.play("fish_bite")
			mini_jump()


func mini_jump():
	animator.play("mini-jump")

# Get the gravity from the project settings to be synced with RigidBody nodes.

#func _physics_process(delta):
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()
