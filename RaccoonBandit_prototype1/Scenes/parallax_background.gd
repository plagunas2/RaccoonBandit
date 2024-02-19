extends ParallaxBackground

var scroll_speed = 200

func _ready():
	$Timer.start()

# Called when the node enters the scene tree for the first time.
func _process(delta):
	scroll_base_offset -= Vector2(scroll_speed,0) * delta

func _on_timer_timeout():
	#default = 0.15
	#Fast testing = 0.25
	scroll_speed = scroll_speed + scroll_speed * 0.15
	
	#default = 15
	#Fast testing = 5
	$Timer.wait_time = 15
