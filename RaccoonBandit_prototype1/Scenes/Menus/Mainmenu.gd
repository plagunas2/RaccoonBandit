extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/test_level_pt2.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/tutorial_page.tscn")





func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/settings_menu.tscn")
