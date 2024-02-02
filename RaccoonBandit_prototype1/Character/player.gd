extends CharacterBody2D

@export var jump_velocity : float = -500.0
@export var double_jump_velocity : float =-350

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else: 
		has_double_jumped = false
		
		#Handle Jump landing
		if was_in_air == true:
			land()
		
		was_in_air = false

	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#normal jump
			jump()
			
		elif not has_double_jumped:
			 #double jump
			double_jump()
	
	# Handle slide
	if Input.is_action_pressed("down"):
		if not is_on_floor():
			velocity.y = velocity.y * -2
		slide()
		velocity.y += gravity * delta

	move_and_slide()
	update_animation()

func update_animation():
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("Jump Loop")
		
		else:
			animated_sprite.play("Running")
	
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("Jump Start")
	animation_locked = true
		
func double_jump():
	velocity.y = double_jump_velocity
	animated_sprite.play("Jump Double")
	animation_locked = true
	has_double_jumped = true
	
func land():
	animated_sprite.play("Jump End")
	animation_locked = true
	
func slide():
	animated_sprite.play("Sliding")
	animation_locked = true
	
#func collide():
	#if collide
		#hurt animation
		#check position
		#if in default position
			#push character back, maybe one quarter of screen back
		#if not in default position
			#die animation
	
#movement
	#default position is ....(stay static here)
	#if not in default position
		#"pick up speed" until back into default position

func _on_animated_sprite_2d_animation_finished():
	if(["Jump End", "Jump Start", "Jump Double", "Sliding"].has(animated_sprite.animation)):
		animation_locked = false
