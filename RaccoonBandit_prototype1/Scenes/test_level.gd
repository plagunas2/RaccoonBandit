extends Node2D


#preload obstacles
var barrel_scene = preload("res://Scenes/obstacles/barrel.tscn")
var cardboardBox_scene = preload("res://Scenes/obstacles/cardboardBox.tscn")
var trashBag_scene = preload("res://Assets/Obstacles/Garbage_Bag.png")
var obstacle_types := [barrel_scene, cardboardBox_scene, trashBag_scene]
var obstacles : Array

#game variables
#todo: player position, score, etc,
var last_obstacle


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	generate_obs()
	pass
	
	
func generate_obs():
	#generate obstacles
	if obstacles.is_empty():
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
