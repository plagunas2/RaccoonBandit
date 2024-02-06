extends CharacterBody2D

enum CharacterState {
	RUNNING,
	CAUGHT,
	GAME_OVER
}

signal police_attack

var character_state : CharacterState = CharacterState.RUNNING
var police_officer : AnimatedSprite2D

# Ensure to set these variables in the inspector
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var police_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	reset_police_animation()
 	# Assuming the signal is connected through the Godot editor. If not, uncomment the next line.
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))

func reset_police_animation():
	police_animated_sprite.play("run")

#func _on_body_entered(body: PhysicsBody2D):
	#if body.is_in_group("player"):
		#print("NPC detected player, emitting signal.")
		#body.emit_signal("caught_by_police")  # Emitting signal that the player script should catch.
#
#func _on_player_caught():
	#character_state = CharacterState.CAUGHT
	#reset_police_animation()
	#print("Playing attacking animation.")
	#police_animated_sprite.play("attack")

func _on_body_entered(body: PhysicsBody2D):
	if body.is_in_group("player"):
		print("NPC detected player.")
		#character_state = CharacterState.CAUGHT
		police_animated_sprite.play("attack")
		emit_signal("police_attack")
		#var timer = get_tree().create_timer(3.0)
		#await timer.timeout
		#get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
		_after_police_attack()

func _after_police_attack():
	var timer = get_tree().create_timer(1.5)
	await timer.timeout
	get_tree().change_scene_to_file("res://Scenes/Menus/game_over_menu.tscn")
	print("switch to game over screen")
	
#func _process(delta):
	#match character_state:
		#CharacterState.RUNNING:
			## Your existing code for the raccoon movement
			#pass
			#
		#CharacterState.CAUGHT:
			## Handle caught state (e.g., display game over screen)
			#pass
#
		#CharacterState.GAME_OVER:
			## You can handle any additional logic for the game over state here
			#pass

## Signal handler for when the player is caught by the police
#func _on_player_caught_by_police():
	#character_state = CharacterState.CAUGHT
	#reset_police_animation()
	## Play "attack" animation for the police officer
	#police_animated_sprite.play("attack")
