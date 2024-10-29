class_name PositionLockLerpSmoothing
extends CameraControllerBase

@export var vert_cross_length:float = 5.0
@export var horiz_cross_length:float = 5.0
@export var follow_speed:float = 2.0
@export var catchup_speed:float = 4.0
@export var leash_distance:float = 200.0

@onready var vessel:Vessel = %Vessel
#camera position
var _target_pos: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = Vector3(target.position.x, dist_above_target, target.position.z)
	rotation_degrees = Vector3(-90, 0, 0)
	_target_pos = position 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current: 
		return 
	
	var distance_from_vessel = global_position.distance_to(vessel.global_position)
	if distance_from_vessel > leash_distance:
		#once the vessel breaks the leash the camera will now follow the vessel
		_target_pos = vessel.global_position
		_target_pos.y = dist_above_target
		position = position.lerp(_target_pos, catchup_speed * delta)
		
	#since player is within the bounds there is no need for catchup_speed
	else: 
		_target_pos = vessel.global_position
		_target_pos.y = dist_above_target
		position = position.lerp(_target_pos, follow_speed * delta)
		
	
	super(delta)
	
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
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
