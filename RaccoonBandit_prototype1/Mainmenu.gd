extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file( "res://Scenes/main_level.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://tutorial page.tscn")
