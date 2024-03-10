extends CharacterBody2D

#-600 NORMAL
@onready var jump_velocity = -950.0
#-475 NORMAL
@onready var double_jump_velocity = -715

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var police_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var parallax = get_parent().get_node("ParallaxBackground")
@onready var sound = get_parent().get_node("AudioStreamPlayer2D")

@onready var hud = get_parent().get_node("HUD")

signal final_death
signal fireball_hitting_raccoon

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = false
var is_dead : bool = false

var lives = 3:
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
var out_screen
var after_jump

func _ready():
	add_to_group("player")
	$FireballDetection.add_to_group("player_fire_shape")
	$FireballDetection/MainFireBallCollision.add_to_group("player_fire_shape")
	$FireballDetection/SlideFireBallCollision.add_to_group("player_fire_shape")
	magnet = false
	bat = false
	lives = 3
	out_screen = false
	after_jump = false
	
	$MainCollisionShape.disabled = false
	$FireballDetection/MainFireBallCollision.disabled = false
	
	$SlideCollisionShape.disabled = true
	$FireballDetection/SlideFireBallCollision.disabled = true
	
	$FireballDetection.connect("area_entered", Callable(self, "_on_fireball_entered"))
	
func _on_fireball_entered(area):
	if area.is_in_group("fireball_area"):
		is_dead = true
		_livescounter()
	elif area.is_in_group("aerial_deadly"):
		is_dead = true
		_livescounter()
	
func _on_police_attack():
	print("Player caught by police, playing dying animation.")
	if is_dead == false:
		is_dead = true
		_livescounter()

func _livescounter():
	lives -= 1
	if lives <= 0: 
		await get_tree().create_timer(0.5).timeout
		parallax.scroll_speed = 0
		if(out_screen == false):
			dying()
		elif(out_screen == true):
			explode()
		emit_signal("final_death")
	else:
		out_screen = false
		respawn()

func _physics_process(delta):	
	character_positon = self.global_position
	
	# Add the gravity.
	if not is_on_floor():
		velocity.x = 0
		#NORMAL: velocity += Vector2(0, gravity) * delta
		if after_jump == true:
			velocity += Vector2(0, gravity * 3) * delta
		elif after_jump == false:
			velocity += Vector2(0, gravity * 2.5) * delta
		was_in_air = true
	else: 
		has_double_jumped = false
		
		#Handle Jump landing
		if was_in_air == true:
			if not is_dead:
				after_jump = false
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
				after_jump = true
	
		# Handle slide
		if Input.is_action_pressed("down"):
			$SlideCollisionShape.disabled = false
			$FireballDetection/SlideFireBallCollision.disabled = false
			$SlideCollisionShape.visible = true
			$FireballDetection/SlideFireBallCollision.visible = true
			
			$MainCollisionShape.disabled = true
			$FireballDetection/MainFireBallCollision.disabled = true
			$MainCollisionShape.visible = false
			$FireballDetection/MainFireBallCollision.visible = false
			slide()
		else:
			default_collision_shapes()
			animated_sprite.set_offset(Vector2(0, 0))
		
	move_and_slide()
	update_animation()
	update_position(delta)

func default_collision_shapes():
	$MainCollisionShape.disabled = false
	$FireballDetection/MainFireBallCollision.disabled = false
	$MainCollisionShape.visible = true
	$FireballDetection/MainFireBallCollision.visible = true
	
	$SlideCollisionShape.disabled = true
	$FireballDetection/SlideFireBallCollision.disabled = true
	$SlideCollisionShape.visible = false
	$FireballDetection/SlideFireBallCollision.visible = false

func update_animation():
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("Jump Loop")
		
		else:
			animated_sprite.play("Running")
	
func explode():	
	gravity = 0
	velocity.y = 0
	animated_sprite.set_offset(Vector2(500, 0))
	animated_sprite.move_to_front()
	animated_sprite.set_scale(Vector2(0.5,0.5))
	
	sound.playExplode()
	animated_sprite.play("Explode")
	animation_locked = true

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
	animated_sprite.set_offset(Vector2(0, -20))
	animated_sprite.play("Sliding")
	animation_locked = true
	
func idle():
	animated_sprite.play("idle")
	animation_locked = true

func respawn():
	print("respawned")
	if is_dead == true:
		var time_to_play = parallax.scroll_speed * -0.003125 + 3.25
		
		$FireballDetection/MainFireBallCollision.set_deferred("disabled", true)
		animated_sprite.visible = false
		#calculate y
		self.global_position = home_position
		position.x = home_position.x * 2
		await get_tree().create_timer(time_to_play).timeout
		jump()
		animated_sprite.visible = true
		
		$FireballDetection/MainFireBallCollision.disabled = false
		is_dead = false
		
#func update_deadly_collision():
	#if collide
		#livescounter		

func update_position(delta):
	if not is_dead:
		if (character_positon.x < home_position.x):
			var offset = home_position.x - character_positon.x
			position += Vector2(offset, 0) * delta
		elif (character_positon.x > home_position.x):
			var offset = character_positon.x - home_position.x
			position -= Vector2(offset, 0) * delta
		
		if is_on_floor():
			position += Vector2(parallax.scroll_speed, 0) * delta

func _on_animated_sprite_2d_animation_finished():
	if(["Jump End", "Jump Start", "Jump Double", "Sliding"].has(animated_sprite.animation)):
		animation_locked = false
		
func getPowerup(string):
	if(string == "magnet"):
		print("magnet power up!")
		magnet = true
		$MagnetTimer.start()
	if(string == "life"):
		print("life power up!")
		lives += 1
	if(string == "bat"):
		print("Weapon power up!")
		bat = true
		$BatTimer.start()
		#TODO activate bat animation
	
		
func _on_timer_timeout():
	magnet = false

func _on_visible_on_screen_enabler_2d_screen_exited():
	if(self.global_position.x < 0):
		is_dead = true
		out_screen = true
		_livescounter()

func batDetectCol():
	pass
	#TODO base on timer
	#while timer on, if collision detected in front of player, DESTROY!!!
	#also activate bat swing animation


func _on_bat_timer_timeout():
	bat = false
