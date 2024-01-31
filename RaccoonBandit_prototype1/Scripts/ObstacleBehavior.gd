extends Area2D

var speed 
var parallax_background
var parallax_layer
var ground_speed
var par_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
	speed = parallax_background.scroll_speed
	#par_speed = parallax_background.scroll_base_offset.x
	#parallax_layer = parallax_background.get_node("ParallaxLayer")
	#ground_speed = parallax_background.get_layer_speed("ParallaxLayer")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.LEFT * speed * delta
	#speed = speed * .1
	print(position)
	
	#pass
