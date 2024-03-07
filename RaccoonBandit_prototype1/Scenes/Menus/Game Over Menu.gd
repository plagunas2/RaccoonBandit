extends Control

var highscore = 0
var current_score = 0

@onready var score_value: Label = $VBoxContainer5/ScoreHBoxContainer/ScoreValue
@onready var highscore_value: Label = $VBoxContainer5/HighscoreHBoxContainer/HighscoreValue

func _ready():
	set_process_input(true)  # Enable input processing for this script

func _process(_delta):
	# Check for mouse click in the _process function
	if Input.is_action_just_pressed("retry"):
		_on_retry_pressed()

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/test_level_pt2.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_score_changed(trashcollected):
	print("on score changed called")
	score_value.text = str(trashcollected)
	if current_score > highscore:
		highscore = trashcollected
		highscore_value.text = str(highscore)
