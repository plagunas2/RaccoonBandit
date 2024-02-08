extends Node2D

var ground_tile = preload("res://Scenes/GroundStuff/ground_tile.tscn")

var ground_types := [ground_tile]
var ground_tiles : Array

var last_ground

var screen_size : Vector2i
var ground_height : int

#spawn intervals determine the time between obstacle spawns
#change this for longer or shorter distances between obstacles
var min_spawn_interval = 0.0 
var max_spawn_interval = 0.0

var parallax_layer
var groundNode
var ground

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the timer when the scene is ready
	
	var parallax_background = get_parent().get_node("ParallaxBackground")
	parallax_layer =  parallax_background.get_node("ParallaxLayer")
	groundNode = parallax_layer.get_node("Ground")
	ground = groundNode.get_node("Sprite2D")
	
	$Timer.start()

func _on_timer_timeout():
	# Create a new obstacle instance
	var ground_type = ground_types[randi() % ground_types.size()].instantiate()
	print(ground_type) #debugging print statement
	
	ground_type.position = Vector2(0,0) #positions obs to the left of the screen
	
	# Add the obstacle to the scene
	add_child(ground_type)

	# Set a new random spawn interval for the next obstacle
	$Timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	
