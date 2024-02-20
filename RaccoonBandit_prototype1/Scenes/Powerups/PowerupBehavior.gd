extends Area2D

var magnet : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func pop(): #when instantiated, power up 'pops' up from dumpster
	pass

func _on_body_entered(body):
	magnet = true #character script should check this and then set up timer for powerup if true
	#play music
	queue_free()
	
