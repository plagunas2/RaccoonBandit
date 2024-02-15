extends Node2D

var npc
var player
var parallax_background
var global_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	npc = $npc
	player = $Player
	parallax_background = $ParallaxBackground
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	global_speed = parallax_background.scroll_speed
