extends CharacterBody2D

var custom_velocity = Vector2()
var xpos
var speed = 200

@onready var fireball_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	add_to_group("fireball")
	fireball_animated_sprite.play("right")
	custom_velocity.x = speed
	velocity = custom_velocity
	
	$ObstacleDetection.connect("body_entered", Callable(self, "_on_obstacle_entered"))
	
func _on_obstacle_entered(body: PhysicsBody2D):
	if body.is_in_group("obstacle"):
		queue_free()
	elif (body.is_in_group("player")):
		queue_free()
	
func _physics_process(_delta):
	speed = get_parent().global_speed
	custom_velocity.x = speed
	
	velocity = custom_velocity
	move_and_slide()
	
	xpos = self.global_position.x
	left_screen()

func _on_fireball_shot():
	fireball_animated_sprite.play("right")
	
#to delete item when it leaves the screen
func left_screen():
	if (xpos < 0):
		queue_free() 
	elif (xpos == 2095):
		queue_free()

func make_queue_free():
	queue_free()
