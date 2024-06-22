extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var speed: float = 0.3

func _process(delta: float) -> void:
	rotate_y(speed * delta)
	translate_object_local(Vector3.FORWARD * speed * delta)
