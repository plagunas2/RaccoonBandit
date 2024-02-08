extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var npc = $npc
	var player = $Player
	
	npc.connect("police_attack", Callable(player, "_on_police_attack"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
