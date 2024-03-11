extends CharacterBody2D

func _ready():
	add_to_group("obstacle")

func get_power():
	return "magnet";
