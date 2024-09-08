extends Node3D

var forward_max_speed = 6.0
var forward_speed_knob = 0.0

@onready var speed_multiplier = 1

#func _input(input_event: InputEvent):
	#if input_event is InputEventMIDI:
		#if input_event.controller_number == 75: #knob 8
			#forward_speed_knob = 0.5 - float(input_event.controller_value) / 127 
			#print(input_event.controller_value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(input_event: InputEvent) -> void:
	if input_event is InputEventMIDI:
		if input_event.pitch == 43:
			if input_event.message == MIDI_MESSAGE_NOTE_ON:
				speed_multiplier = 4
			if input_event.message == MIDI_MESSAGE_NOTE_OFF:
				speed_multiplier = 1
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#var gravity = 10.0
var speed = 3.0

func _physics_process(delta):
	var vel_y = 0
	var vel_x = 0
	vel_y += delta * Input.get_axis('move_down', 'move_up') * speed * 0.6
	vel_y += delta * forward_max_speed * forward_speed_knob * speed_multiplier
	vel_x = delta * Input.get_axis("move_left", "move_right") * speed * 15
#	look_at(Vector3(0,0,0))
	#move_and_slide()
	position.z += vel_y
	position.z = max(position.z,0)
	position.z = clampf(position.z,0,550)
	


func _on_main_camera_move_speed(value) -> void:
	forward_speed_knob = value
	#pass # Replace with function body.


func _on_main_fov_extra_camera() -> void:
	pass # Replace with function body.
