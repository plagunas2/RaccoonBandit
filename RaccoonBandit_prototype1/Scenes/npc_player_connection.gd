extends Node2D

var canvas_modulate
var npc
var player
var parallax_background
var global_speed
var game_over_menu
var HUD
var ground_parallax

# Called when the node enters the scene tree for the first time.
func _ready():
	#var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	#if save_file!=null:
		#high_score = save_file.get_32()
	#else:
		#high_score = 0
		#save_game()
	
	parallax_background = $ParallaxBackground
	ground_parallax = $ParallaxBackground2
	HUD = $HUD
	npc = $npc
	player = $Player
	canvas_modulate = $CanvasModulate
	game_over_menu = $"Game Over Menu"
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))
	player.connect("left_screen", Callable(npc, "_idle"))
	HUD.connect("score_6", Callable(npc, "_on_score_6"))
	print("Connecting score_changed signal to game_over_menu")
	HUD.connect("score_changed", Callable(game_over_menu, "_on_score_changed"))
	player.connect("final_death", Callable(npc, "_after_police_attack"))
	#player.killed.connect(_on_player_killed)
	canvas_modulate.connect("color_change", Callable(parallax_background, "_set_gradient"))
	canvas_modulate.connect("color_change", Callable(ground_parallax, "_set_gradient"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	global_speed = parallax_background.scroll_speed
	
#func save_game():
	#var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	#save_file.store_32(high_score)
	#
#func _on_player_killed():
	#game_over_menu.set_score(score)
