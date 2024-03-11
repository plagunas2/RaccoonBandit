extends CharacterBody2D

var speed 
var parallax_background

var xpos

# Called when the node enters the scene tree for the first time.
func _ready():
	$FireballDetection.add_to_group("obstacle_fire_shape")
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
	$FireballDetection.connect("area_entered", Callable(self, "_on_obstacle_entered"))
	$AnimatedSprite2D.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0):
		speed = parallax_background.scroll_speed
	else:
		speed = 0
	position += Vector2.LEFT * speed * delta
	
	xpos = self.global_position.x
	left_screen()

#to delete item when it leaves the screen
func left_screen():
	if (xpos < -100):
		queue_free()

func _on_obstacle_entered(area):
	if area.is_in_group("fireball_area"):
		$MainCollision.set_deferred("disabled", true)
		$FireballDetection/FB.set_deferred("disabled", true)
		$Sprite2D.visible = false
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.move_to_front()
		$AnimatedSprite2D.play("default")
		var timer = get_tree().create_timer(0.65)
		await timer.timeout
		queue_free()

func _on_bat_detection_body_entered(body):
	if(body.get_name() == "Player" && body.bat == true):
		print("bat detected!")
		$MainCollision.set_deferred("disabled", true)
		$FireballDetection/FB.set_deferred("disabled", true)
		$Sprite2D.visible = false
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.move_to_front()
		$AnimatedSprite2D.play("default")
		var timer = get_tree().create_timer(0.65)
		await timer.timeout
		queue_free()
