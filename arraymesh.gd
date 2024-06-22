extends MeshInstance3D


var rings = 100
var radial_segments = 100
var radius = 1


var surface_array

var verts
var uvs
var normals
var indices

#AUDIO STUFF
var spectrum
var VU_COUNT = rings
const FREQ_MAX = 11050.0

const WIDTH = 1152
const HEIGHT = 648

const MIN_DB = 60



#AUDIO STUFF


func generate_mesh():
	var arr_mesh = ArrayMesh.new()
	
	surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	
	verts = PackedVector3Array()
	uvs = PackedVector2Array()
	normals = PackedVector3Array()
	indices = PackedInt32Array()
	
	# Vertex indices.
	var thisrow = 0
	var prevrow = 0
	var point = 0

	# Loop over rings.
	var prev_hz = 0
	for i in range(rings + 1):
		var v = float(i) / rings
		var w = sin(PI * v)
		var y = cos(PI * v)
		
		var hz = (i + 1) * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var current_radius = radius + (energy * radius)
#		var clr = Color(hz/6500,0,0,1)
##		draw_rect(Rect2(w * i, HEIGHT - height, w, height), clr)
		prev_hz = hz


		# Loop over segments in ring.
		for j in range(radial_segments + 1):
			
			var u = float(j) / radial_segments
			var x = sin(u * PI * 2.0)
			var z = cos(u * PI * 2.0)
			var vert = Vector3(x * current_radius * w, y * current_radius, z * current_radius * w)
			verts.append(vert)
			normals.append(vert.normalized())
			uvs.append(Vector2(u, v))
			point += 1

			# Create triangles in ring using indices.
			if i > 0 and j > 0:
				indices.append(prevrow + j - 1)
				indices.append(prevrow + j)
				indices.append(thisrow + j - 1)

				indices.append(prevrow + j)
				indices.append(thisrow + j)
				indices.append(thisrow + j - 1)

		prevrow = thisrow
		thisrow = point
	
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_TEX_UV] = uvs
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_INDEX] = indices
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
	mesh = arr_mesh
	# Saves mesh to a .tres file with compression enabled.
#	ResourceSaver.save(mesh, "res://sphere.tres", ResourceSaver.FLAG_COMPRESS)

# Called when the node enters the scene tree for the first time.
func _ready():
	spectrum = AudioServer.get_bus_effect_instance(0,0)
	generate_mesh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	generate_mesh()
	rotate_z(delta/10.0)


#func audiostuff():
#	var w = WIDTH / VU_COUNT
#	var prev_hz = 0
#	for i in range(1, VU_COUNT+1):
#		var hz = i * FREQ_MAX / VU_COUNT;
#		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
#		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
#		var height = energy * HEIGHT
#		var clr = Color(hz/6500,0,0,1)
##		draw_rect(Rect2(w * i, HEIGHT - height, w, height), clr)
#		prev_hz = hz
#
