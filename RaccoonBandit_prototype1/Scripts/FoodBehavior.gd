extends Area2D

var speed 
var parallax_background
var scoreCounter

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_parent().name == "FoodGenerator"): #if node is within FoodGen node
		print(get_parent().name)
		parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
		scoreCounter = get_parent().get_parent().get_node("HUD")
	else: #if node is NOT in FoodGen node (aka, FoodArc node) -> the node is a level further 
		#down so it needs to get another parent_node to access the parallax background
		parallax_background = get_parent().get_parent().get_parent().get_node("ParallaxBackground")
		scoreCounter = get_parent().get_parent().get_parent().get_node("HUD")
	print(parallax_background)
	speed = parallax_background.scroll_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.LEFT * speed * delta
	
#when player collects the food, food disappears and score goes up by one
func _on_body_entered(body):
	if (body.name == "Player"):
		scoreCounter.increase_score()
		queue_free()


