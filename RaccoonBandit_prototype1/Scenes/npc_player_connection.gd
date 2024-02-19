extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var npc = $npc
	var player = $Player
	var HUD = $HUD
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))
	HUD.connect("score_6", Callable(npc, "_on_score_6"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
