extends Node2D

var ground_tile = preload("res://Scenes/GroundStuff/ground_tile.tscn")

var ground_types := [ground_tile]
var ground_tiles : Array

var last_ground

var screen_size : Vector2i
var ground_height : int

var parallax_background

var is_ground_in_spawn

var global_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = get_parent().get_node("ParallaxBackground")

func _process(_delta):
	global_speed = parallax_background.scroll_speed
	# Create a new obstacle instance
	var ground_type = ground_types[randi() % ground_types.size()].instantiate()
	#print(ground_type) #debugging print statement
	
	ground_type.position = Vector2(0,0) #positions obs to the left of the screen
	
	# Add the obstacle to the scene
	if($Area2D.has_overlapping_bodies() == false):
		add_child(ground_type)
