extends CharacterBody2D

enum CharacterState {
	RUNNING,
	CAUGHT,
	GAME_OVER
}

var character_state : CharacterState = CharacterState.RUNNING
var police_officer : AnimatedSprite2D

# Ensure to set these variables in the inspector
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var police_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	reset_police_animation()

func _process(delta):
	match character_state:
		CharacterState.RUNNING:
			# Your existing code for the raccoon movement

			# Check for collision with police officer
			if animated_sprite.get_rect().intersects(police_animated_sprite.get_rect()):
				character_state = CharacterState.CAUGHT
				reset_police_animation()
				# Play "attack" animation for the police officer
				police_animated_sprite.play("attack")

		CharacterState.CAUGHT:
			# Handle caught state (e.g., display game over screen)
			if Input.is_action_just_pressed("retry"):
				character_state = CharacterState.GAME_OVER
				get_tree().change_scene("res://Scenes/game_over_screen.tscn")

		CharacterState.GAME_OVER:
			# You can handle any additional logic for the game over state here
			pass

func reset_police_animation():
	police_animated_sprite.play("run")



#extends CharacterBody2D
#
#enum CharacterState {
	#IDLE,
	#RUNNING,
	#CAUGHT,
	#GAME_OVER
#}
#
#var character_state : CharacterState = CharacterState.IDLE
#var police_officer : AnimatedSprite2D
#
## Ensure to set these variables in the inspector
#@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
#@onready var police_animated_sprite : AnimatedSprite2D = $PoliceOfficer/AnimatedSprite2D
#
#func _process(delta):
	#match character_state:
		#CharacterState.IDLE:
			## Handle start button press
			#if Input.is_action_just_pressed("ui_accept"): # Assuming "ui_accept" is the input action for your start button
				#character_state = CharacterState.RUNNING
				##animated_sprite.play("Running")
				## Play "run" animation for the police officer
				#police_animated_sprite.play("run")
				#
		#CharacterState.RUNNING:
			## Your existing code for the raccoon movement
			#
			## Check for collision with police officer
			#if animated_sprite.get_rect().intersects(police_animated_sprite.get_rect()):
				#character_state = CharacterState.CAUGHT
				##animated_sprite.play("Caught")
				## Play "attack" animation for the police officer
				#police_animated_sprite.play("attack")
				#
		#CharacterState.CAUGHT:
			## Handle caught state (e.g., display game over screen)
			## You can add transitions to the game over screen here
			#if Input.is_action_just_pressed("retry"):
				#character_state = CharacterState.IDLE
				#character_state = CharacterState.GAME_OVER
				#get_tree().change_scene("res://Scenes/game_over_screen.tscn")
				##animated_sprite.play("Idle")
				## Reset the police officer's animation
				#police_animated_sprite.play("idle")
#
		#CharacterState.GAME_OVER:
			## You can handle any additional logic for the game over state here
			#pass

#const speed = 300.0
#var current_state = SIDE_LEFT
#
#var dir = Vector2.RIGHT
#var start_pos
#
#var is_roaming = true
#var is_chatting = false
#
#var player
#var player_in_chat_zone = false
#
#enum {
	#IDLE,
	#MOVE
#}
#
#func _ready():
	#randomize()
	#start_pos = position
#func _process(delta):
	#if current_state == 0 or current_state == 1:
		#$AnimatedSprite2D.play("idle")
	#elif current_state == 2 and !is_chatting:
		#if dir.x == 1:
			#$AnimatedSprite2D.play("run")
			#
	#if is_roaming:
		#match current_state:
			#IDLE:
				#pass
			#MOVE:
				#move(delta)
				#
#func choose(array):
	#array.shuffle()
	#return array.front()
				#
#func move(delta):
	#if !is_chatting:
		#position += dir * speed * delta
#
#
#func _on_chat_detection_area_body_entered(body):
	#if body.has_method("player"):
		#player = body
		#player_in_chat_zone = true
#
#
#func _on_chat_detection_area_body_exited(body):
	#if body.has_method("player"):
		#player_in_chat_zone = false
#
#
#func _on_timer_timeout():
	#$Timer.wait_time = choose([0.5, 1, 1.5])
	#current_state = choose([IDLE, MOVE])
