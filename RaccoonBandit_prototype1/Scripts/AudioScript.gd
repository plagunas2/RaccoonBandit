extends AudioStreamPlayer2D

var eatSound = preload("res://Sounds/eatingSFX.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func playEat():
	self.set_stream(eatSound)
	play()
