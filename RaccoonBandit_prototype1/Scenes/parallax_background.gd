extends ParallaxBackground

var scroll_speed = 200
# Called when the node enters the scene tree for the first time.
func _process(delta):
	scroll_base_offset -= Vector2(scroll_speed,0) * delta
	pass
