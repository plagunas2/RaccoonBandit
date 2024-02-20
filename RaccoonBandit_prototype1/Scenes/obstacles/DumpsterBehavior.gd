extends Area2D

#var magnet = preload("res://Scenes/Powerups/magnet.tscn")
var powerups = ["magnet"]

var parallax_background
var sound
var root
var player
var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
	sound = get_parent().get_parent().get_node("AudioStreamPlayer2D")
	root = get_parent().get_parent()
	player = root.get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0):
		speed = parallax_background.scroll_speed
	else:
		speed = 0
	position += Vector2.LEFT * speed * delta

func _on_body_entered(body):
	print("detected player body")
	if(body.name == "Player" && Input.is_action_pressed("down")):
		#debugging print statements
		print("player y ", body.global_position.y)
		print("dumpster y ", self.global_position.y)
		
		var yDistance = body.global_position.y - self.global_position.y
		print("distance of p and d: ", yDistance)
		if(yDistance < -100): #make sure player is ABOVE the dumpster to destroy it
			
			var power_type = powerups[randi() % powerups.size()]
			player.getPowerup(power_type)
			sound.playSmash()
			queue_free()
