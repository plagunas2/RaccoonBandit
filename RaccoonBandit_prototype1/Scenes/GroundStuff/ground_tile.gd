extends CharacterBody2D

var speed
var gen
var xpos

func _ready():
	speed = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = get_parent().global_speed
	position += Vector2.LEFT * speed * delta
	xpos = self.global_position.x
	left_screen()

func left_screen():
	if (xpos < 0):
		queue_free()
