extends ParallaxBackground

var scroll_speed = 400

func _ready():
	$Timer.start()

# Called when the node enters the scene tree for the first time.
func _process(delta):
	scroll_base_offset -= Vector2(scroll_speed,0) * delta

func _on_timer_timeout():
	#default = 0.15
	#Fast testing = 0.25
	if(scroll_speed <= 800):
		scroll_speed = scroll_speed + scroll_speed * 0.1
	else:
		scroll_speed = scroll_speed + scroll_speed * 0.01
	
	#default = 15
	#Fast testing = 5
	$Timer.wait_time = 15
