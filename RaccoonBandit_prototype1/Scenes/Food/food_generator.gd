extends Node2D

var food_arc_scene = preload("res://Scenes/Food/FoodArc.tscn")
var food_types = [food_arc_scene]
@onready var foodArcPos = $Marker2D #get pos for food arc, replace later

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	var food_type = food_types[randi() % food_types.size()].instantiate()
	print(food_type) #debugging print statement
	
	food_type.position = foodArcPos.global_position
