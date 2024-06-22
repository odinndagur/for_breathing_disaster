extends CharacterBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#var gravity = 10.0
var speed = 3.0

func _physics_process(delta):
	velocity.y += delta * Input.get_axis('move_down', 'move_up') * speed * 0.6
	velocity.x = delta * Input.get_axis("move_left", "move_right") * speed * 15
#	look_at(Vector3(0,0,0))
	move_and_slide()
