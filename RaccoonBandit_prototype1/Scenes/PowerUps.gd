extends AudioStreamPlayer2D

var magnetSound = preload("res://Sounds/magnetSFX.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playPower(powerType):
	if (powerType == "magnet"):
		self.set_stream(magnetSound)
		play()
