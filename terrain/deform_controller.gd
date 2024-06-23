extends Node

var deform: float

const VU_COUNT = 16
const FREQ_MAX = 11050.0

const WIDTH = 400
const HEIGHT = 100

const MIN_DB = 60

var spectrum
var mat

var current_vu = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spectrum = AudioServer.get_bus_effect_instance(0,0)
	mat = $"0_0".get_surface_override_material(0)
#	pass # Replace with function body.


func _input(event):
	var cam = $"../Camera3D"
	
	var sun = $"../DirectionalLight3D"
	#y er hringinn í kring
	#x er sól rís/sest
	if event is InputEventPanGesture:
		var pan_delta = event.get_delta()
		deform += (pan_delta[1]/10)
		print(pan_delta)
		var children = get_children()
		for c in children:
			c.set("blend_shapes/Deform",clampf(deform,-1.5,1.5))
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R:
			var children = get_children()
			deform = -1.5
			for c in children:
				c.set("blend_shapes/Deform",clampf(deform,-1.5,1.5))
		if event.keycode == KEY_UP:
			current_vu = min(current_vu+1,VU_COUNT)
		if event.keycode == KEY_DOWN:
			current_vu = max(current_vu-1,0)
	
	if event is InputEventMouseMotion:
		var mouse_pos = event.position
		var viewport_size = get_viewport().get_visible_rect().size
#		var angle = fmod((PI + (mouse_pos - (viewport_size/2)).angle()),PI*2)
#		if angle >= (PI * 2):
#			angle = angle - (PI * 2)
		print("Viewport Resolution is: ", viewport_size)
		var x = mouse_pos[0]
		var y = mouse_pos[1]
		var angle = remap(y,0,viewport_size[1],-PI,PI)
		var angle2 = remap(x,0,viewport_size[0],-PI,PI)
		print("angle: ", angle)
#		var mapped_angle = remap(angle,0,PI*2,0,360)
		var current_rotation = sun.get("rotation")
		current_rotation[1] = angle
		current_rotation[0] = angle2
		sun.set("rotation",current_rotation)
		print("x: ", x, " y: ",y, " mouse_pos: ", mouse_pos)
		#cam.set("size",remap(y,0,1,300,700))
#		var children = get_children()
#		for c in children:
#			c.set("blend_shapes/Deform",remap(x,0,viewport_size[0],-1,1))
#	print(event.as_text())
#	var num = int(event.as_text())
#	print(event.is_action_type())
#	if num:
#		var output_num = remap(num,1,9,-1,1)
#		var children = get_children()
#		for c in children:
#			c.set("blend_shapes/Deform",output_num)
			
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var w = WIDTH / VU_COUNT
	var prev_hz = 0
#	for i in range(1, VU_COUNT+1):
	for i in range(current_vu, current_vu+1):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var height = energy * HEIGHT
#		print("height: ", height, " energy: ", energy, " magnitude: ",magnitude)
		prev_hz = hz
#		mat.albedo_color = mat.albedo_color * 0.8 + Color(energy, 1-energy, energy/2) * 0.2
		var old_r = mat.albedo_color.r
		mat.albedo_color = Color(old_r * 0.8 + energy * 0.2,0,0)


#blend_shapes/Deform
