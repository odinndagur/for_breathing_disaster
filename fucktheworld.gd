extends Node3D

@export var chroma_shader: ColorRect
@export var grain_shader: ColorRect
@export var bw_shader: ColorRect

@export var cam: Camera3D

signal camera_move_speed
signal planet_spin_speed

signal camera_move_speed_multiplier

signal fov_extra_camera



@export_range (0,10) var destruction_slider: float:
	set(value):
		update_shaders(value)
		print(value)
		
#@export_range (0,1) var world_color : float:
	#set(value):
		#update_world_color(value)
		
		
#AUDIO STUFF
@onready var spectrum = AudioServer.get_bus_effect_instance(0,0)

var VU_COUNT = 100
const FREQ_MAX = 11050.0

const MIN_DB = 60
#/AUDIO STUFF



var grain_base_amount = 0.051
var grain_base_size = 1.445

var chromatic_base_r = Vector2(3,0)
var chromatic_base_g = Vector2(-1,1)
var chromatic_base_b = Vector2(-3,0)

var r_energy: float
var g_energy: float
var b_energy: float

var shader_value: float

#var sky_base_top_color = Color(0,0,1,1)
var sky_base_top_color = Color.from_hsv(215,91,46)

var pad_states: Array[Dictionary] = [
	{
		"pitch": 36,
		"pressed": false,
		"current_pressure": 0
	},
	{
		"pitch": 37,
		"pressed": false,
		"current_pressure": 0
	},
	{
		"pitch": 38,
		"pressed": false,
		"current_pressure": 0
	},
	{
		"pitch": 39,
		"pressed": false,
		"current_pressure": 0
	},
	{
		"pitch": 40,
		"pressed": false,
		"current_pressure": 0
	},
	{
		"pitch": 41,
		"pressed": false,
		"current_pressure": 0
	},
	{
		"pitch": 42,
		"pressed": false,
		"current_pressure": 0
	},
	{
		"pitch": 43,
		"pressed": false,
		"current_pressure": 0
	},
]

#var controller_map = {"10":18,"11":19,"12":16,"13":17,"14":91,"15":79,"16":72}

func logify(normalized_linear_value):
	var output_logified_value
	if normalized_linear_value < 0.5:
		output_logified_value = normalized_linear_value * 0.2
	else:
		output_logified_value = normalized_linear_value * 1.8 - 0.8
	return output_logified_value

func _input(input_event: InputEvent) -> void:
	if input_event is InputEventMIDI:
		#print(input_event)
		if input_event.message == MIDI_MESSAGE_NOTE_ON:
			pad_states[input_event.pitch - 36]["pressed"] = true
			print("note ON")
		if input_event.message == MIDI_MESSAGE_NOTE_OFF:
			pad_states[input_event.pitch - 36]["pressed"] = false
			print("note off")
		if input_event.message == MIDI_MESSAGE_AFTERTOUCH:
			pad_states[input_event.pitch - 36]["current_pressure"] = input_event.pressure
			print("aftertouch")
		#print("noteon", input_event.message == MIDI_MESSAGE_NOTE_ON)
		var normalized_value = float(input_event.controller_value) / 127
		match input_event.controller_number:
			74: #knob 2
				update_shaders(normalized_value * 10)
			71: #knob 3
				#update_world_color(normalized_value)
				pass
			76: #knob 4
				update_screen_color(normalized_value)
			73: #knob 7 - himinn top
				#sky_curve
				#var new_value = remap(normalized_value,0, 1, 0, 46)
				#var new_color = Color.from_hsv(215.0/360.0,91.0/100.0,46.0/100 * new_value)
				#cam.environment.sky.sky_material.sky_top_color = new_color
				cam.environment.sky.sky_material.sky_curve = max(logify(normalized_value),0.000787401574803)
				print("himinn top: ", normalized_value)
				cam.environment.sky.sky_material.ground_curve = max(logify(normalized_value),0.000787401574803)
				#print("normalized value: ", normalized_value, "logified: ", logify(normalized_value), "new_color: ", new_color)
				pass
			79: #knob 15 - himinn bottom
				cam.environment.sky.sky_material.sky_curve = logify(normalized_value)
				cam.environment.sky.sky_material.ground_curve = logify(normalized_value)
				print("himinn bottom: ", normalized_value)
				pass
			77: #knob 5
				#cam.environment.sky.sky_material.sky_top_color = normalized_value * sky_base_top_color + (1-normalized_value) * Color.BLACK
				pass
			93: #knob 6
				var extra = 0
				if pad_states[5]["pressed"]:
					extra = randf()
				cam.environment.sky_rotation.z = deg_to_rad(360) * normalized_value + extra
				pass
			18: #knob 10
				fov_extra_camera.emit(normalized_value)
				pass
			19: #knob 11
				pass
			16: #knob 12
				pass
			17: #knob 13
				pass
			91: #knob 14
				#var new_value = remap(normalized_value,0, 1, 0, 46)
				var new_color = Color.from_hsv(215.0/360.0,91.0/100.0,30.0/100 * normalized_value)
				cam.environment.sky.sky_material.sky_top_color = new_color
				pass
			72: #knob 16
				planet_spin_speed.emit(1 + (normalized_value * 500)) #-100 til 100
				pass
			75: #knob 8
				camera_move_speed.emit((0.5 - normalized_value) * 2) #-1 til 1


func get_audio_energy_for_range():
	var prev_hz = 0
	for i in range(VU_COUNT + 1):
		var v = float(i) / VU_COUNT
		var w = sin(PI * v)
		var y = cos(PI * v)
		
		var hz = (i + 1) * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		prev_hz = hz

func update_screen_color(value):
	if not bw_shader:
		return
	bw_shader.material.set("shader_parameter/saturation",value)

#func update_world_color(value):
	#if not cam:
		#return
	#cam.environment.sky.sky_material.sky_top_color = sky_base_top_color * value
	

func update_shaders(value):
	if not chroma_shader:
		return
	shader_value = value
	grain_shader.material.set("shader_parameter/grain_amount",grain_base_amount/2 + grain_base_amount * value / 2)
	grain_shader.material.set("shader_parameter/grain_size", grain_base_amount/2 + grain_base_size * value / 3)
	
	chroma_shader.material.set("shader_parameter/r_displacement", chromatic_base_r * value *1.5 + Vector2(r_energy * 10,r_energy * 10))
	chroma_shader.material.set("shader_parameter/g_displacement", chromatic_base_g * value *3)
	chroma_shader.material.set("shader_parameter/b_displacement", chromatic_base_b * value)
	#chroma_shader.material.set("shader_parameter/r_displacement", r_energy * 10 * value *1.5)
	#chroma_shader.material.set("shader_parameter/g_displacement", g_energy * 10 * value *3)
	#chroma_shader.material.set("shader_parameter/b_displacement", b_energy * 10 * value)
	#print(r_energy,g_energy,b_energy)
	
	if value == 10.0:
		chroma_shader.material.set("shader_parameter/r_displacement", Vector2(900,900))
		chroma_shader.material.set("shader_parameter/g_displacement", Vector2(900,900))
		chroma_shader.material.set("shader_parameter/b_displacement", Vector2(900,900))
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OS.open_midi_inputs()
	#print(OS.get_connected_midi_inputs())
	update_shaders(destruction_slider)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var r_magnitude: float = spectrum.get_magnitude_for_frequency_range(1, 200).length()
	r_energy = clamp((MIN_DB + linear_to_db(r_magnitude)) / MIN_DB, 0, 1)
	
	var g_magnitude: float = spectrum.get_magnitude_for_frequency_range(201, 2000).length()
	g_energy = clamp((MIN_DB + linear_to_db(g_magnitude)) / MIN_DB, 0, 1)
	
	var b_magnitude: float = spectrum.get_magnitude_for_frequency_range(2001, FREQ_MAX).length()
	b_energy = clamp((MIN_DB + linear_to_db(b_magnitude)) / MIN_DB, 0, 1)
	
	#shader_value = 10.0
	
	chroma_shader.material.set("shader_parameter/r_displacement", shader_value * (chromatic_base_r * shader_value *1.5 + Vector2(r_energy * 100,r_energy * 100)))
	chroma_shader.material.set("shader_parameter/r_displacement", shader_value * (chromatic_base_g * shader_value *1.5 + Vector2(-g_energy * 1000,-g_energy * 1000)))
	chroma_shader.material.set("shader_parameter/r_displacement", shader_value * (chromatic_base_b * shader_value *1.5 + Vector2(b_energy * 1000,-b_energy * 1000)))
	
	if pad_states[0]["pressed"]:
		chroma_shader.material.set("shader_parameter/r_displacement", Vector2(50,50))
	
	#if pad_states[1]["pressed"]:
		#update_shaders(10.0)
	#print(r_energy,g_energy,b_energy)	
	pass
