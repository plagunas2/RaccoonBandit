extends CharacterBody2D

@export var jump_velocity : float = -600.0
@export var double_jump_velocity : float = -475

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var police_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var parallax = get_parent().get_node("ParallaxBackground")
@onready var sound = get_parent().get_node("AudioStreamPlayer2D")

@onready var hud = get_parent().get_node("HUD")

signal final_death

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = false
var is_dead : bool = false

var lives=3:
	set(value):
		lives = value
		hud.init_lives(lives)

#[0] = x, [1] = y
var home_position = Vector2(825.0, 860.0)
var character_positon = self.global_position

#powerups
var magnet : bool
var bat : bool

signal left_screen

func _ready():
	add_to_group("player")
	magnet = false
	bat = false
	lives = 3
	#connect("caught_by_police", Callable(self, "_on_caught_by_police"))
	
func _on_police_attack():
	print("Player caught by police, playing dying animation.")
	is_dead = true
	if is_on_floor():
		lives -= 1
		if lives <= 0: 
			parallax.scroll_speed = 0
			dying()
			emit_signal("final_death")
		else:
			respawn()
		#explode midair animation
		#dying_mid_air

func _physics_process(delta):
	character_positon = self.global_position
	# Add the gravity.
	if not is_on_floor():
		velocity.x = 0
		velocity += Vector2(0, gravity) * delta
		was_in_air = true
	else: 
		has_double_jumped = false
		
		#Handle Jump landing
		if was_in_air == true:
			if not is_dead:
				land()
				velocity.y = 0
				velocity.x = 0
		
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
	update_position(delta)

func update_animation():		
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("Jump Loop")
		
		else:
			animated_sprite.play("Running")
	
func dying():
	sound.playDeath()
	animated_sprite.play("Dying")
	animation_locked = true
	
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

func respawn():
	print("respawned")
	if is_dead == true:
		is_dead = false
		$CollisionShape2D.disabled = true
		animated_sprite.visible= false
		await get_tree().create_timer(0.2).timeout
		self.global_position = home_position
		jump()
		animated_sprite.visible =true
		
		#_physics_process(home_position)
		
		$CollisionShape2D.disabled = false
		#parallax.scroll_speed = 200
		#process_mode = Node.PROCESS_MODE_INHERIT
		
		
		
		
#func update_deadly_collision():
	#if collide
		#hurt animation(blink in and out) for 5 secs and invincible
		#next time die 
			#and stop background		

func update_position(delta):
	if (character_positon.x == home_position.x):
		velocity.x = 0
	elif (character_positon.x < home_position.x):
		if not is_dead:
			velocity.x += 3
		else:
			velocity.x = 0
	elif (character_positon.x > home_position.x):
		var offset = character_positon.x - home_position.x
		position -= Vector2(offset, 0) * delta
		
	if is_on_floor():
		position += Vector2(parallax.scroll_speed, 0) * delta
 
#collect powerup(attack, invincible)
	#change running animation to run attacking with bat animation
	#timer to switch back to default
	#destroy obstacles in the way

func _on_animated_sprite_2d_animation_finished():
	if(["Jump End", "Jump Start", "Jump Double", "Sliding"].has(animated_sprite.animation)):
		animation_locked = false
		
		
func getPowerup(string):
	if(string == "magnet"):
		print("magnet power up!")
		magnet = true
		$MagnetTimer.start()
		
func _on_timer_timeout():
	magnet = false


func _on_visible_on_screen_enabler_2d_screen_exited():
	dying()
	is_dead = true
	emit_signal("left_screen")
	parallax.scroll_speed = 0
