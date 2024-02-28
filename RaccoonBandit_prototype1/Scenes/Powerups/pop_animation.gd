extends Node2D

var count
var a = 0
var b = 0
var finished = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Timer.start() # Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	popup()

func popup():
	if (finished == false): #increase size
		if(a<4):
			a += .25
			b += .25
		if (a == 4):
			finished = true
		self.scale = Vector2(a,b)
	if (finished == true && a > 0): #decrease size
		if(a>0):
			a -= .25
			b -= .25
		self.scale = Vector2(a,b)
	if(finished == true && a <= 0):
		queue_free()
	
func playSound():
	pass
