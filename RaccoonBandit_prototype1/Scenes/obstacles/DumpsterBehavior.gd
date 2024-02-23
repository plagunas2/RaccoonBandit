extends Area2D

#var magnet = preload("res://Scenes/Powerups/magnet.tscn")
var powerups = ["magnet"]

var parallax_background
var sound
var root
var player
var speed
var xpos
var powerPop

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
	sound = get_parent().get_parent().get_node("AudioStreamPlayer2D")
	root = get_parent().get_parent()
	player = root.get_node("Player")
	powerPop = root.get_node("PowerupPopUp")
	add_to_group("obstacle_fire_shape")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0):
		speed = parallax_background.scroll_speed
	else:
		speed = 0
	position += Vector2.LEFT * speed * delta
	
	xpos = self.global_position.x
	left_screen()

#to delete item when it leaves the screen
func left_screen():
	if (xpos < -50):
		queue_free()

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
			sound.playSmash()
			powerPop.PowerPop(power_type)
			player.getPowerup(power_type)
			queue_free()

func _on_area_entered(area):
	if area.is_in_group("fireball_area"):
		queue_free()
