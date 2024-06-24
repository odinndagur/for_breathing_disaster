extends Node3D

@export var chroma_shader: ColorRect
@export var grain_shader: ColorRect
#@export var world_environment: WorldEnvironment
@export var camera: Camera3D
@export var light_slider: HSlider

@export var terrain : Node3D
@export var kula : Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	light_slider.value = camera.environment.fog_light_energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_chroma_toggled(button_pressed):
	chroma_shader.visible = button_pressed


func _on_grain_toggled(button_pressed):
	grain_shader.visible = button_pressed


func _on_light_value_changed(value):
	camera.environment.fog_light_energy = value
	print(value)



func _on_kula_toggled(button_pressed):
	kula.visible = button_pressed


func _on_terrain_toggled(button_pressed):
	terrain.visible = button_pressed
