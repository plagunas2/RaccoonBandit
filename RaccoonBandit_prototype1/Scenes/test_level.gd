extends Node2D

var barrel_scene = preload("res://Scenes/obstacles/barrel.tscn")
var cardboardBox_scene = preload("res://Scenes/obstacles/cardboardBox.tscn")
var trashBag_scene = preload("res://Scenes/obstacles/trashBag.tscn")
var mailbox_scene = preload("res://Scenes/obstacles/mailBox.tscn")
var obstacle_types := [barrel_scene, cardboardBox_scene, trashBag_scene, mailbox_scene]
var obstacles : Array

var last_obs
var generatorPos

# Called when the node enters the scene tree for the first time.
func _ready():
	generatorPos = $Marker2D.global_position # Replace with function body.
	#generatorPos = position
	generate_obs()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
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
	
	
