extends Area2D

var magnet : bool
var xpos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xpos = self.global_position.x
	left_screen()

#to delete item when it leaves the screen
func left_screen():
	if (xpos < 0):
		queue_free()
	
	
func pop(): #when instantiated, power up 'pops' up from dumpster
	pass

func _on_body_entered(body):
	magnet = true #character script should check this and then set up timer for powerup if true
	#play music
	queue_free()
	
