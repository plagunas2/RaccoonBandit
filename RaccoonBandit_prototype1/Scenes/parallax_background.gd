extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _process(delta):
	scroll_base_offset -= Vector2(100, 0) * delta
	pass
