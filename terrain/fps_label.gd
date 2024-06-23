extends Label
@onready var audioPlayer := $"../AudioStreamPlayer"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	text = ""
	text += "fps: " + str(Engine.get_frames_per_second())
	text += "other variable: " + str(audioPlayer)

