extends CharacterBody2D

var custom_velocity = Vector2()
var xpos
var speed = 200

@onready var fireball_animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	add_to_group("fireball")
	$ObstacleDetection.add_to_group("fireball_area")
	fireball_animated_sprite.play("right")
	custom_velocity.x = speed
	velocity = custom_velocity
	
	$ObstacleDetection.connect("area_entered", Callable(self, "_on_area_entered"))
	
func _on_area_entered(area: Area2D):
	if area.is_in_group("obstacle_fire_shape"):
		queue_free()
	elif (area.is_in_group("player_fire_shape")):
		queue_free()
	
func _physics_process(_delta):
	speed = get_parent().global_speed
	custom_velocity.x = speed * 1.2
	
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
