class_name HorizontalAutoScroll
extends CameraControllerBase

@export var top_left: Vector2 = Vector2(-5, -5)
@export var bottom_right: Vector2 = Vector2(5, 5)
@export var auto_scroll_speed: Vector3 = Vector3(1, 0, 0)

@export var box_width:float = 11.0
@export var box_height:float = 11.0

var scroll_position: Vector3 = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	scroll_position = target.position
	position = Vector3(scroll_position.x, dist_above_target, scroll_position.z)
	rotation_degrees = Vector3(-90, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current: 
		return 
		
	if draw_camera_logic:
		draw_logic()
	
	# Moves the scroll position and vessel at the same speed.
	scroll_position += auto_scroll_speed * delta
	
	target.position += auto_scroll_speed * delta
	
	# Updates the cam pos to match with the scroll pos.
	position = Vector3(scroll_position.x, dist_above_target, scroll_position.z)
	
	# Calculate the left side of boundary box.
	var box_left = scroll_position.x + top_left.x
	var box_right = scroll_position.x + bottom_right.x
	var box_top = scroll_position.z + top_left.y
	var box_bottom = scroll_position.z + bottom_right.y
	
	# Clamp is used to keep the player within the boundries of the box.
	target.position.x = clamp(target.position.x, box_left, box_right)
	target.position.z = clamp(target.position.z, box_top, box_bottom)
	
	super(delta)
	
		
func draw_logic() -> void:

	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -box_width / 2
	var right:float = box_width / 2
	var top:float = -box_height / 2
	var bottom:float = box_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
