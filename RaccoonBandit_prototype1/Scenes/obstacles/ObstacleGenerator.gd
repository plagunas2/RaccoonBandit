extends Node2D

var barrel_scene = preload("res://Scenes/obstacles/barrel.tscn")
var cardboardBox_scene = preload("res://Scenes/obstacles/cardboardBox.tscn")
var trashBag_scene = preload("res://Scenes/obstacles/trashBag.tscn")
var mailbox_scene = preload("res://Scenes/obstacles/mailBox.tscn")
var foodStand_scene = preload("res://Scenes/obstacles/foodStand.tscn")
var dumpster1 = preload("res://Scenes/obstacles/dumpCol.tscn")
var obstacle_types := [barrel_scene, cardboardBox_scene, dumpster1, trashBag_scene, mailbox_scene, foodStand_scene]
var obstacles : Array

var last_obs

var screen_size : Vector2
var ground_height : int

#spawn intervals determine the time between obstacle spawns
#change this for longer or shorter distances between obstacles
var min_spawn_interval 
var max_spawn_interval

var parallax_background
var parallax_layer
var groundNode
var ground
var scroll_speed
var seconds_in_screen

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the timer when the scene is ready
	parallax_background = get_parent().get_node("ParallaxBackground")
	parallax_layer =  parallax_background.get_node("ParallaxLayer")
	groundNode = parallax_layer.get_node("Ground")
	ground = groundNode.get_node("Sprite2D")
	screen_size = get_viewport().content_scale_size
	
	min_spawn_interval = 3.0 
	max_spawn_interval = 8.0
	
	$Timer.start()
	
func _process(_delta):
	scroll_speed = parallax_background.scroll_speed
	seconds_in_screen = screen_size.x/scroll_speed
	min_spawn_interval = seconds_in_screen * 0.2
	max_spawn_interval = seconds_in_screen * 0.9

func _on_timer_timeout():
	# Create a new obstacle instance
	var obs_type = obstacle_types[randi() % obstacle_types.size()].instantiate()
	print(obs_type) #debugging print statement
	
	obs_type.position = Vector2(0,0) #positions obs to the left of the screen
	
	# Add the obstacle to the scene
	add_child(obs_type)

	# Set a new random spawn interval for the next obstacle
	$Timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	
