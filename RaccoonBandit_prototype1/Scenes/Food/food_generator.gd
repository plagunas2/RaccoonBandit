extends Node2D

var food_arc_scene = preload("res://Scenes/Food/FoodArc.tscn")
var food_types = [food_arc_scene]

var min_spawn_interval = 10.0 
var max_spawn_interval = 15.0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("timer starts!")
	$Timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	$Timer.start()


func _on_timer_timeout():
	print("timer timeour!")
	var food_type = food_types[randi() % food_types.size()].instantiate()
	print(food_type) #debugging print statement
	
	food_type.global_position = Vector2(0,0)
	print("food pos ", food_type.global_position)
	
	add_child(food_type)
	
	$Timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	
