extends Area2D

var speed 
var parallax_background
var scoreCounter
var audio
var xpos

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_parent().name == "FoodGenerator"): #if node is within FoodGen node
		print(get_parent().name)
		parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
		scoreCounter = get_parent().get_parent().get_node("HUD")
		audio = get_parent().get_parent().get_node("AudioStreamPlayer2D")
	else: #if node is NOT in FoodGen node (aka, in FoodArc node) -> the node is a level further 
		#down so it needs to get another parent node to access the parallax, score, & audio nodes
		parallax_background = get_parent().get_parent().get_parent().get_node("ParallaxBackground")
		scoreCounter = get_parent().get_parent().get_parent().get_node("HUD")
		audio = get_parent().get_parent().get_parent().get_node("AudioStreamPlayer2D")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0):
		speed = parallax_background.scroll_speed
	else:
		speed = 0
	position += Vector2.LEFT * speed * delta
	
	xpos = self.global_position.x
	left_screen()
	
#when player collects the food, food disappears and score goes up by one
func _on_body_entered(body):
	if (body.name == "Player"):
		scoreCounter.increase_score()
		audio.playEat()
		queue_free()

#To delete item when it leaves the screen
func left_screen():
	if (xpos < 0):
		queue_free()
