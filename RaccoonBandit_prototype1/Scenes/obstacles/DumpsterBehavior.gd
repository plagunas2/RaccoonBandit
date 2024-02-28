extends Area2D

#var magnet = preload("res://Scenes/Powerups/magnet.tscn")
var powerups = ["magnet", "life"]
var power_type

var redDump = "res://Assets/Obstacles/Containers_1.png"
var yellowDump = "res://Assets/Obstacles/Containers_2.png"
var blueDump = "res://Assets/Obstacles/Containers_3.png"
#var power_type

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
	$Dumpster1/AnimatedSprite2D.visible = false
	
	power_type = powerups[randi() % powerups.size()] #set random powertype on instantiation
	get_dumpster(power_type)

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
			sound.playSmash()
			powerPop.PowerPop(power_type)
			player.getPowerup(power_type)
			queue_free()

func _on_area_entered(area):
	if area.is_in_group("fireball_area"):
		$Dumpster1/CollisionPolygon2D.set_deferred("disabled", true)
		$CollisionShape2D.set_deferred("disabled", true)
		$Dumpster1/Sprite2D.visible = false
		$Dumpster1/AnimatedSprite2D.visible = true
		$Dumpster1/AnimatedSprite2D.move_to_front()
		$Dumpster1/AnimatedSprite2D.play("default")
		var timer = get_tree().create_timer(0.65)
		await timer.timeout
		queue_free()
		
func get_dumpster(power_type): #change dumpster sprite depending on powerup type
	if(power_type == "magnet"):
		$Dumpster1/Sprite2D.set_texture(load(redDump))
	if(power_type == "life"):
		$Dumpster1/Sprite2D.set_texture(load(blueDump))
