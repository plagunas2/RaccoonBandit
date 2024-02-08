extends CharacterBody2D

var parallax_background
var speed

func _ready():
	parallax_background = get_parent().get_parent().get_node("Node2D/ParallaxBackground")
	speed = parallax_background.scroll_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if(parallax_background != null):
	speed = parallax_background.scroll_speed
	#else:
		#speed = 0
	position += Vector2.LEFT * speed * delta
