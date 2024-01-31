extends Node2D

var barrel_scene = preload("res://Scenes/obstacles/barrel.tscn")
var cardboardBox_scene = preload("res://Scenes/obstacles/cardboardBox.tscn")
var trashBag_scene = preload("res://Scenes/obstacles/trashBag.tscn")
var mailbox_scene = preload("res://Scenes/obstacles/mailBox.tscn")
var foodStand_scene = preload("res://Scenes/obstacles/foodStand.tscn")
var obstacle_types := [barrel_scene, cardboardBox_scene, trashBag_scene, mailbox_scene, foodStand_scene]
var obstacles : Array

var last_obs

var screen_size : Vector2i
var ground_height : int

var min_spawn_interval = 3.0
var max_spawn_interval = 8.0

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

	screen_size = get_window().size
	ground_height = ground.texture.get_height()
	print("ready")
	
	$Timer.start()

#func _on_Timer_timeout():
	# Create a new obstacle instance


func _on_timer_timeout():
	# Create a new obstacle instance
	print("timeout")
	var obs_type = obstacle_types[randi() % obstacle_types.size()].instantiate()
	print(obs_type)
	
	print("add")
	
	var obs_height = obs_type.get_node("Sprite2D").texture.get_height()
	var obs_scale = obs_type.get_node("Sprite2D").scale
	var obs_x : int = ground.texture.get_size().x + 100
	#var obs_y : int = ground.texture.get_size().y - ground_height - (obs_height * obs_scale.y / 2) + 5
	obs_type.position = Vector2(800, 100)
	
	# Add the obstacle to the scene
	add_child(obs_type)

	print('pos') #testing
	print(obs_type.position)
	

	# Set a new random spawn interval for the next obstacle
	$Timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	
