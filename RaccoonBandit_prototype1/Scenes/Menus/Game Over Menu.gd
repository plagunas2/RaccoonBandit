extends Control

signal retry

var highscore
var current_score

@onready var score_value: Label = $VBoxContainer5/ScoreHBoxContainer/ScoreValue
@onready var highscore_value: Label = $VBoxContainer5/HighscoreHBoxContainer/HighscoreValue

func _ready():
	set_process_input(true)  # Enable input processing for this script
	highscore = 0
	current_score = 0

func _process(_delta):
	# Check for mouse click in the _process function
	#if Input.is_action_just_pressed("retry"):
	#	_on_retry_pressed()

	score_value.text = str(current_score)
	highscore_value.text = str(highscore)

func _on_retry_pressed():
	emit_signal("retry")

func _on_quit_pressed():
	get_tree().quit()

func _score_changed(new_score):
	print("on score changed called with new_score: " , new_score)
	current_score = new_score
	if current_score > highscore:
		highscore = current_score
		highscore_value.text = str(highscore)
		
#func set_score(value):
	#score_value.text = "Score: " + str(value)
	#
#func set_high_score(value):
	#highscore_value.text = "Hi-Score: " + str(value)
