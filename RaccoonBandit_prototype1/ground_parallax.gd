extends ParallaxBackground

var scroll_speed = 400

func _ready():
	scroll_speed = get_parent().get_node("ParallaxBackground").scroll_speed

# Called when the node enters the scene tree for the first time.
func _process(delta):
	scroll_speed = get_parent().get_node("ParallaxBackground").scroll_speed
	scroll_base_offset -= Vector2(scroll_speed,0) * delta
