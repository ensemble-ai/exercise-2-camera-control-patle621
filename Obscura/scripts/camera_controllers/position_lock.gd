class_name PositionLock
extends CameraControllerBase

#@export var vert_cross_length:float = 5.0
#@export var horz_cross_length:float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current: 
		return 
	
	position = target.position
	
	if draw_camera_logic:
		draw_logic()
		
	#var tpos = target.global_position
	#var cpos = global_position

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var size_cross = 5
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(-size_cross, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(size_cross, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, -size_cross, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, size_cross, 0))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_position = global_position
	
	await get_tree().process_frame
	mesh_instance.queue_free()
	
