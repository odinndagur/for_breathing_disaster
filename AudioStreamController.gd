extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var input_devices = AudioServer.get_input_device_list()
	for idx in range(input_devices.size()):
		var device = input_devices[idx]
		print(idx, ': ', device)
		#if device.contains('Default'):
			#print(idx, ': ', device)
			#AudioServer.input_device = device
			#AudioServer.set("input_device",device)
		if device.contains('H6'):
			print(idx, ': ', device)
			AudioServer.input_device = device
			AudioServer.set("input_device",device)
			
			
			#AudioServer.set_indexed("input_device",idx)
	#for device in input_devices:
		#print(device.)
	#print(AudioServer.get_input_device_list())
	#play(400)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
