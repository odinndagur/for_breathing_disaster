extends Node3D
@export var meshInstance: MeshInstance3D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print(meshInstance.transparency)
	if meshInstance.transparency == 0.3:
		meshInstance.transparency = 0
	else:
		meshInstance.transparency = 0.3
#	print(meshInstance.get_active_material(0))
#	print("lol")
