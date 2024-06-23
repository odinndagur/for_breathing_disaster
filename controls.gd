extends Node3D
@export var meshInstance: MeshInstance3D
@export var chroma_shader: ColorRect
@export var grain_shader: ColorRect
@export var world_environment: WorldEnvironment



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


func _on_chroma_toggled(button_pressed):
	chroma_shader.visible = button_pressed


func _on_grain_toggled(button_pressed):
	grain_shader.visible = button_pressed


func _on_seethru_toggled(button_pressed):
	print(meshInstance.material_override.transparency)
	if button_pressed:
		meshInstance.material_override.transparency = 1
	else:
		meshInstance.material_override.transparency = 0


func _on_light_value_changed(value):
	world_environment.environment.fog_light_energy = value
	print(value)
