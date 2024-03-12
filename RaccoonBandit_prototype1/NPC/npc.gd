extends CharacterBody2D

enum CharacterState {
	RUNNING,
	CAUGHT,
	GAME_OVER
}

var fireball_scene = ResourceLoader.load("res://Scenes/fireball.tscn", "PackedScene")

signal police_attack
signal fireball_shot
signal game_is_over

var character_state : CharacterState = CharacterState.RUNNING
var police_officer : AnimatedSprite2D
var chat_bubble : Control
var game_over

# Ensure to set these v ariables in the inspector
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var police_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

const lines: Array[String] = [
	"Hey, you seem pretty strong!",
	"Wanna spar?",
	"Wait...",
	"I shouldn't waste my energy before an important battle...",
	"Well, I'll see you at the buffet!",
]

func _ready():
	reset_police_animation()
	chat_bubble = $Dialogue
	chat_bubble.hide_dialogue()
	chat_bubble.update_text("Control, this is Officer Trashley. We've got a dumpster diver on the loose. I'm on my way. Over.")
	chat_bubble.show_dialogue()
	var timer = get_tree().create_timer(6) 
	await timer.timeout
	chat_bubble.hide_dialogue()
	
	#check to see if the fireball_scene loaded successfully here
	#if not fireball_scene:
	#	print("Failed to load fireball scene.")
	#else:
	#	print("Fireball scene loaded successfully.")
	
 	# Assuming the signal is connected through the Godot editor. If not, uncomment the next line.
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$ChatDetectionArea.connect("body_entered", Callable(self, "_on_body_entered_chat"))
	$FireDetectionArea.connect("body_entered", Callable(self, "_fire"))
	
	game_over = false
	
func reset_police_animation():
	police_animated_sprite.play("run")
	
func _on_body_entered_chat(body: PhysicsBody2D):
	if body.is_in_group("player"):
		print("NPC Chat Box")
		#DialogueManager.start_dialog(global_position, lines)
		chat_bubble.update_text("I'm gaining on you, little rascal! You can't outrun the long arm of the law!")
		chat_bubble.show_dialogue()
		var timer = get_tree().create_timer(6) 
		await timer.timeout
		chat_bubble.hide_dialogue()

func _on_body_entered(body: PhysicsBody2D):
	if body.is_in_group("player"):
		print("NPC detected player.")
		#character_state = CharacterState.CAUGHT
		police_animated_sprite.play("attack")
		emit_signal("police_attack")
		await get_tree().create_timer(1).timeout
		if (game_over == false):
			reset_police_animation()

func _after_police_attack():
	game_over = true
	police_animated_sprite.play("idle")
	var timer = get_tree().create_timer(2)
	await timer.timeout
	emit_signal("game_is_over")
	
func _idle():
	police_animated_sprite.play("idle")
	
	_after_police_attack()
	
# function to display the new dialogue when the score reaches 8
func _on_score_6():
	print("Dialogue when score is 6")
	chat_bubble.update_text("This raccoon is taking too much trash! Time to clean up the streets.")
	chat_bubble.show_dialogue()
	var timer = get_tree().create_timer(6) 
	await timer.timeout
	chat_bubble.hide_dialogue()
	
func _fire(body: PhysicsBody2D):
	print("fireball_scene: ", fireball_scene)
	if body.is_in_group("player") and fireball_scene:	
		police_animated_sprite.play("attack3")
		var f = fireball_scene.instantiate()
		get_parent().call_deferred("add_child", f)
		emit_signal("fireball_shot")
		f.position.x = position.x - 50
		f.position.y = position.y + 10
		await get_tree().create_timer(0.35).timeout
		if (game_over == false):
			reset_police_animation()
		
		#dialogue update
		chat_bubble.update_text("Hey there, little trash bandit! I've got a hot surprise for you! 🔥🦝")
		chat_bubble.show_dialogue()
		var timer = get_tree().create_timer(4) 
		await timer.timeout
		chat_bubble.hide_dialogue()
		
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
