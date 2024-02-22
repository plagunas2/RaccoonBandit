extends Node2D

var magnet = preload("res://Scenes/Powerups/magnet_pop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func PowerPop(powerup):
	var power
	if(powerup == "magnet"):
		power = magnet.instantiate()
		power.position = Vector2(0,0)
		add_child(power)
	
