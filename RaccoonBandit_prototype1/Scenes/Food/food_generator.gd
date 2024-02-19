extends Node2D

var food_arc_scene = preload("res://Scenes/Food/FoodArc.tscn")
var banana_scene = preload("res://Scenes/Food/Banana.tscn")
var cheese_sandwich_scene = preload("res://Scenes/Food/CheeseSandwich.tscn")
var flower_food_scene = preload("res://Scenes/Food/FoodMushFlowers.tscn")
var food_types = [food_arc_scene, banana_scene, cheese_sandwich_scene, flower_food_scene]

var min_spawn_interval
var max_spawn_interval
var scroll_speed
var seconds_in_screen
var screen_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	min_spawn_interval = 10.0 
	max_spawn_interval = 15.0
	#print("timer starts!")
	$Timer.wait_time = 3.0
	$Timer.start()

func _process(_delta):
	scroll_speed = get_parent().global_speed
	seconds_in_screen = screen_size.x/scroll_speed
	min_spawn_interval = seconds_in_screen * 0.2
	max_spawn_interval = seconds_in_screen * 0.9

func _on_timer_timeout():
	print("timer timeour!")
	var food_type = food_types[randi() % food_types.size()].instantiate()
	print(food_type) #debugging print statement
	
	food_type.global_position = Vector2(0,0)
	print("food pos ", food_type.global_position)
	
	add_child(food_type)
	
	$Timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	
