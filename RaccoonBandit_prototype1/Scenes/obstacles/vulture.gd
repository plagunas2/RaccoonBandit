extends Area2D

var speed 
var parallax_background

var xpos

#if hit bird under belly, shit on cop, cop stops for a couple secs then comes back

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("aerial_deadly")
	parallax_background = get_parent().get_parent().get_node("ParallaxBackground")
	self.connect("area_entered", Callable(self, "_on_player_entered"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(parallax_background.scroll_speed != 0):
		speed = parallax_background.scroll_speed
	else:
		speed = 0
	position += Vector2.LEFT * speed * delta * 2.3
	
	xpos = self.global_position.x
	left_screen()

func _on_player_entered(area):
	if (area.is_in_group("player_fire_shape")):
		$AnimatedSprite2D.play("dying")
		await get_tree().create_timer(0.75).timeout
		queue_free()

#to delete item when it leaves the screen
func left_screen():
	if (xpos < -100):
		queue_free()
