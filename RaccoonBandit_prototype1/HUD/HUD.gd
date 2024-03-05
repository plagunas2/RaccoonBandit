extends CanvasLayer

var trashcollected = 0

@onready var lives = $Livecount
var ulife_scene = preload("res://Scenes/u_ilives.tscn")

signal score_6

# Called when the node enters the scene tree for the first time.
func _ready():
	$trashcount.text = "Trash: " + str(trashcollected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$trashcount.text  = "Trash: " + str(trashcollected)
	
func increase_score():
	trashcollected += 1
	if trashcollected % 6 == 0:
		print("Score is 6, emitting signal")
		emit_signal("score_6")

func init_lives(amount):
	for ul in $Livecount.get_children():
		ul.queue_free()
	for i in amount:
		print("added child")
		var ul = ulife_scene.instantiate()
		$Livecount.add_child(ul)
		
func final_score():
	return trashcollected
