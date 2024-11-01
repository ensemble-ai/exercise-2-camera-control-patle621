class_name PositionLock
extends CameraControllerBase

@export var vert_cross_length:float = 5.0
@export var horiz_cross_length:float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = Vector3(target.position.x, dist_above_target, target.position.z)
	rotation_degrees = Vector3(-90, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current: 
		return 
	
	position = Vector3(target.position.x, dist_above_target, target.position.z)
	
	super(delta)
	
	if draw_camera_logic:
		draw_logic()

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(-horiz_cross_length, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(horiz_cross_length, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -vert_cross_length))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, vert_cross_length))
	
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(target.position.x, dist_above_target, target.position.z)
	
	await get_tree().process_frame
	mesh_instance.queue_free()
	
