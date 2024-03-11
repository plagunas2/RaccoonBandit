extends Node2D

var canvas_modulate
var npc
var player
var parallax_background
var global_speed
var HUD
var ground_parallax

# Called when the node enters the scene tree for the first time.
func _ready():
	parallax_background = $ParallaxBackground
	ground_parallax = $ParallaxBackground2
	HUD = $HUD
	npc = $npc
	player = $Player
	canvas_modulate = $CanvasModulate
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))
	player.connect("left_screen", Callable(npc, "_idle"))
	HUD.connect("score_6", Callable(npc, "_on_score_6"))
	player.connect("final_death", Callable(npc, "_after_police_attack"))
	canvas_modulate.connect("color_change", Callable(parallax_background, "_set_gradient"))
	canvas_modulate.connect("color_change", Callable(ground_parallax, "_set_gradient"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	global_speed = parallax_background.scroll_speed
