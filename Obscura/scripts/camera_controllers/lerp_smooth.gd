class_name LerpSmoothingTargetFocus 
extends CameraControllerBase

@export var vert_cross_length:float = 5.0
@export var horiz_cross_length:float = 5.0

# Should be faster than vessel.
@export var lead_speed:float = 2.0
@export var catchup_delay_duration:float = 0.15
@export var catchup_speed:float = 2.0
@export var leash_distance:float = 5.0

@onready var vessel:Vessel = %Vessel
# Camera position.
var target_pos: Vector3
var time_stopped: float = 0.0
var previous_position: Vector3
var velocity: Vector3

# Zoom does not work since projection is on orthogonal.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = Vector3(target.position.x, dist_above_target, target.position.z)
	rotation_degrees = Vector3(-90, 0, 0)
	target_pos = position 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	vessel.global_position.y = dist_above_target
	velocity = target.velocity
	var speed = velocity.length()
	
	global_position += target.velocity * delta
	# Checks if player is moving.
	if speed > 0.1:
		# Since player moved the time stopped is reset.
		time_stopped = 0.0
		var direction = velocity.normalized()
		target_pos = vessel.global_position + (direction * leash_distance)
		# Lerps the camera twoards the leash distance.
		global_position = global_position.lerp(target_pos,  lead_speed * delta)
	else:
		time_stopped += delta
		# Once time the catchup delayu duration has passed start moving the camera towards the player.
		if time_stopped >= catchup_delay_duration:
			global_position = global_position.lerp(vessel.global_position, catchup_speed * delta)
	
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
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# Mesh is freed after one update of _process.
	await get_tree().process_frame
	mesh_instance.queue_free()
