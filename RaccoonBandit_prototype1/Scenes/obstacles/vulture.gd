extends CharacterBody2D

var speed 
var parallax_background

var xpos

#if hit bird under belly, shit on cop, cop stops for a couple secs then comes back

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0):
		speed = parallax_background.scroll_speed
	else:
		speed = 0
	position += Vector2.LEFT * speed * delta * 2.3
	
	xpos = self.global_position.x
	left_screen()

#to delete item when it leaves the screen
func left_screen():
	if (xpos < -100):
		queue_free()
