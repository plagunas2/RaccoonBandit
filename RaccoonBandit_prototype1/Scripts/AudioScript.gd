extends AudioStreamPlayer2D

var eatSound = preload("res://Sounds/eatingSFX.mp3")
var smashSound = preload("res://Sounds/crashSFX.mp3")
var death1 = preload("res://Sounds/death1.mp3")
var death2 = preload("res://Sounds/death2.mp3")
var explosion1 = preload("res://Sounds/explosion-6055.mp3")

var deathSounds := [death1, death2]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func playExplode():
	self.set_stream(explosion1)
	play()

func playEat():
	self.set_stream(eatSound)
	play()
	
func playSmash():
	self.set_stream(smashSound)
	play()
	
func playDeath():
	var deathSound = deathSounds[randi() % deathSounds.size()]
	self.set_stream(deathSound)
	play()

