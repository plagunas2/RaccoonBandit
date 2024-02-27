extends Node2D

var _paused:bool = false:
	set(value):
		_paused = value
		get_tree().paused = _paused
		visible = _paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_paused = !_paused

func _on_quit_button_pressed():
		get_tree().change_scene_to_file("res://Scenes/Menus/game_over_menu.tscn")


func _on_resume_button_pressed():
	_paused = false

func _on_settings_button_pressed():
		get_tree().change_scene_to_file("res://Scenes/Menus/settings_menu.tscn")
