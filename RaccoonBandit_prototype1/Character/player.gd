extends CharacterBody2D


@export var speed : float = 150.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float =-100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else: 
		has_double_jumped = false

	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#normal jump
			velocity.y = jump_velocity
		elif not has_double_jumped:
			 #double jump
			velocity.y = double_jump_velocity
			has_double_jumped = true

	move_and_slide()
