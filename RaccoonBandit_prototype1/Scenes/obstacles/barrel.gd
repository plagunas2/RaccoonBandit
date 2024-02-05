extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var speed 
var parallax_background

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
	speed = parallax_background.scroll_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.LEFT * speed * delta

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()
