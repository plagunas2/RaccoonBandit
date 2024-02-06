extends CanvasLayer

var trashcollected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$trashcount.text = "Trash: " + str(trashcollected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$trashcount.text = "Trash: " + str(trashcollected)
	
func increase_score():
	trashcollected += 1
