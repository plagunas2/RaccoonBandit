extends CharacterBody2D

var speed 
var parallax_background

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
	#speed = parallax_background.scroll_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0):
		speed = parallax_background.scroll_speed
	else:
		speed = 0
	position += Vector2.LEFT * speed * delta
