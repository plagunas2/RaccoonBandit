extends Node2D

var npc
var player
var fireball
var parallax_background
var global_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = $ParallaxBackground
	var HUD = $HUD
	npc = $npc
	player = $Player
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))
	player.connect("left_screen", Callable(npc, "_idle"))
	HUD.connect("score_6", Callable(npc, "_on_score_6"))
	npc.connect("raccoon_above_police", Callable(player, "_livescounter"))
	player.connect("final_death", Callable(npc, "_after_police_attack"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	global_speed = parallax_background.scroll_speed
