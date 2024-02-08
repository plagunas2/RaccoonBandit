extends CharacterBody2D

@export var jump_velocity : float = -600.0
@export var double_jump_velocity : float =-475

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var police_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var parallax = get_parent().get_node("ParallaxBackground")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = false
var is_dead : bool = false


#[0] = x, [1] = y
var home_position = Vector2(750.0, 850.0)
var character_positon = self.global_position

func _ready():
	add_to_group("player")
	#connect("caught_by_police", Callable(self, "_on_caught_by_police"))
	
func _on_police_attack():
	print("Player caught by police, playing dying animation.")
	parallax.scroll_speed = 0
	is_dead = true
	if is_on_floor():
		dying()
	else:
		dying()
		#explode midair animation
		#dying_mid_air

func _physics_process(delta):
	character_positon = self.global_position
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else: 
		has_double_jumped = false
		
		#Handle Jump landing
		if was_in_air == true:
			if not is_dead:
				land()
		
		was_in_air = false
	
	#if not dead
	if not is_dead:
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
			slide()

	move_and_slide()
	update_animation()
	update_position()

func update_animation():		
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("Jump Loop")
		
		else:
			animated_sprite.play("Running")
	
func dying():
	animated_sprite.play("Dying")
	animation_locked = true
	#var timer = get_tree().create_timer(2.0)
	#await timer.timeout
	#get_tree().change_scene_to_file("res://Scenes/Menus/game_over_menu.tscn")
	#print("switch to game over screen")
	
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
	if not is_on_floor():
		velocity.y = velocity.y + 1000
	animated_sprite.play("Sliding")
	animation_locked = true
	
func idle():
	animated_sprite.play("idle")
	animation_locked = true
	
#func update_deadly_collision():
	#if collide
		#hurt animation(blink in and out) for 5 secs and invincible
		#next time die 
			#and stop background		

func update_position():
	if (character_positon.x == home_position.x):
		velocity.x = 5
	elif (character_positon.x < home_position.x):
		velocity.x += 5
	elif (character_positon.x > home_position.x):
		velocity.x = 0
 
#collect powerup(attack, invincible)
	#change running animation to run attacking with bat animation
	#timer to switch back to default
	#destroy obstacles in the way

func _on_animated_sprite_2d_animation_finished():
	if(["Jump End", "Jump Start", "Jump Double", "Sliding"].has(animated_sprite.animation)):
		animation_locked = false
