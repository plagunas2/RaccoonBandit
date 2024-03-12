extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY 

@export var gradient_text : GradientTexture1D
#1 real life second = 10 in game minute
@export var INGAME_SPEED = 10.0
@export var INITIAL_HOUR = 12

signal color_change(val : int)

var time : float = 0.0

func _ready():
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	color = gradient_text.gradient.sample(value)
	color_change.emit(gradient_text.gradient.sample(value))
