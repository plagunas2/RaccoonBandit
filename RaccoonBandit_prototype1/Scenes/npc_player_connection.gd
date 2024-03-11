extends Node2D

var npc
var player
var fireball
var parallax_background
var global_speed
var game_over_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	#var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	#if save_file!=null:
		#high_score = save_file.get_32()
	#else:
		#high_score = 0
		#save_game()
	
	parallax_background = $ParallaxBackground
	var HUD = $HUD
	npc = $npc
	player = $Player
	game_over_menu = $"Game Over Menu"
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))
	player.connect("left_screen", Callable(npc, "_idle"))
	HUD.connect("score_6", Callable(npc, "_on_score_6"))
	print("Connecting score_changed signal to game_over_menu")
	HUD.connect("score_changed", Callable(game_over_menu, "_on_score_changed"))
	player.connect("final_death", Callable(npc, "_after_police_attack"))
	#player.killed.connect(_on_player_killed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	global_speed = parallax_background.scroll_speed
	
#func save_game():
	#var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	#save_file.store_32(high_score)
	#
#func _on_player_killed():
	#game_over_menu.set_score(score)
