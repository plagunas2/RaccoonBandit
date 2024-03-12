extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Vacuum.value = 0
	$Bat.value = 0
	print(get_tree())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func vacTimer():
	$Vacuum.value = 10
	var tween = create_tween()
	tween.tween_property($Vacuum, "value", 2.25, 10)
	
	
	
func batTimer():
	$Bat.value = 10
	var tween = create_tween()
	tween.tween_property($Bat, "value", 2.25, 10)
	


