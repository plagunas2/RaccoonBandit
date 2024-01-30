extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file( "res://Scenes/mainScene.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/tutorial page.tscn")

