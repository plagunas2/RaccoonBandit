extends Control

var highscore = 0
var current_score = 0

@onready var score_value: Label = $VBoxContainer5/ScoreHBoxContainer/ScoreValue
@onready var highscore_value: Label = $VBoxContainer5/HighscoreHBoxContainer/HighscoreValue

func _ready():
	set_process_input(true)  # Enable input processing for this script
	score_value.text = str(current_score)
	if current_score > highscore:
		highscore = current_score
		highscore_value.text = str(highscore)

func _process(_delta):
	# Check for mouse click in the _process function
	if Input.is_action_just_pressed("retry"):
		_on_retry_pressed()

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/test_level_pt2.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_score_changed(new_score):
	print("on score changed called with new_score: " , new_score)
	current_score = new_score
	#print("score_value node: ", $VBoxContainer5/ScoreHBoxContainer/ScoreValue)
	#print("highscore_value node: ", $VBoxContainer5/HighscoreHBoxContainer/HighscoreValue)
	#$VBoxContainer5/ScoreHBoxContainer/ScoreValue.text = "Test"
	#$VBoxContainer5/HighscoreHBoxContainer/HighscoreValue.text = "Test"
	score_value.text = str(current_score)
	if current_score > highscore:
		highscore = current_score
		highscore_value.text = str(highscore)
		
#func set_score(value):
	#score_value.text = "Score: " + str(value)
	#
#func set_high_score(value):
	#highscore_value.text = "Hi-Score: " + str(value)
