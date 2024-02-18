extends Area2D

var speed 
var parallax_background
var scoreCounter
var audio
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_parent().name == "FoodGenerator"): #if node is within FoodGen node
		#print(get_parent().name)
		parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
		scoreCounter = get_parent().get_parent().get_node("HUD")
		audio = get_parent().get_parent().get_node("AudioStreamPlayer2D")
		player = get_parent().get_parent().get_node("Player")
	else: #if node is NOT in FoodGen node (aka, in FoodArc node) -> the node is a level further 
		#down so it needs to get another parent node to access the parallax, score, & audio nodes
		parallax_background = get_parent().get_parent().get_parent().get_node("ParallaxBackground")
		#print("background!!!! ", parallax_background)
		scoreCounter = get_parent().get_parent().get_parent().get_node("HUD")
		audio = get_parent().get_parent().get_parent().get_node("AudioStreamPlayer2D")
		player = get_parent().get_parent().get_parent().get_node("Player")
	
	#speed = parallax_background.scroll_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0 && player.magnet == false):
		speed = parallax_background.scroll_speed
		position += Vector2.LEFT * speed * delta
	else:
		speed = 400
		moveToPlayer(delta)
	
	
#when player collects the food, food disappears and score goes up by one
func _on_body_entered(body):
	if (body.name == "Player"):
		scoreCounter.increase_score()
		audio.playEat()
		queue_free()

func moveToPlayer(delta):
	print("player position ", player.global_position)
	print("food position ", self.global_position)
	self.global_position = self.global_position.move_toward(player.global_position, delta*speed)

