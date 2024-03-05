extends Control

var highscore = 0

@onready var score_value: Label = %ScoreValue
@onready var highscore_value: Label = %HighscoreValue

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

func _on_score_changed(new_score):
	score_value.text = str(new_score)
	if new_score > highscore:
		highscore = new_score
		highscore_value.text = str(highscore)
