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
	fireball = $Fireball
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))
	HUD.connect("score_6", Callable(npc, "_on_score_6"))
	npc.connect("fireball_shot", Callable(fireball, "_on_fireball_shot"))
	npc.connect("raccoon_above_police", Callable(player, "_on_raccoon_above_police"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	global_speed = parallax_background.scroll_speed
