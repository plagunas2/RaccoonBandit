extends Node2D


#preload obstacles
var barrel_scene = preload("res://Scenes/obstacles/barrel.tscn")
var cardboardBox_scene = preload("res://Scenes/obstacles/cardboardBox.tscn")
var trashBag_scene = preload("res://Assets/Obstacles/Garbage_Bag.png")
var obstacle_types := [barrel_scene, cardboardBox_scene, trashBag_scene]
var obstacles : Array

#game variables
#todo: player position, score, etc,
var last_obs
var generatorPos


# Called when the node enters the scene tree for the first time.
func _ready():
	 # Replace with function body.
	generatorPos = $obs_generator.position
	#new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	generate_obs()
	
	
	
func generate_obs():
	#generate obstacles
	if obstacles.is_empty():
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		obs = obs_type.instantiate()
		last_obs = obs
		obs.position.x = generatorPos.x
		obs.position.y = generatorPos.y
		add_child(obs)
		obstacles.append(obs)
