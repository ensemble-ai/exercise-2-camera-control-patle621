class_name FourWaySpeedupPushZone
extends CameraControllerBase

var push_ratio:float = 5

# Outer Box
var pushbox_top_left: Vector2 = Vector2(-10, -10)
var pushbox_bottom_right: Vector2 = Vector2(10, 10)

# Inner Box
var pushbox_zone_top_left: Vector2 = Vector2(-5, -5)
var pushbox_zone_bottom_right: Vector2 = Vector2(5, 5)

var velocity: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	rotation_degrees = Vector3(-90, 0, 0)
	position = target.position
	
func _process(delta: float) -> void:
	
	if !current:
		return
		
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	# Boundries of outer box.
	var outer_box_left = pushbox_top_left.x
	var outer_box_right = pushbox_bottom_right.x
	var outer_box_top = pushbox_top_left.y
	var outer_box_bottom = pushbox_bottom_right.y
	
	# Boundries of inner box.
	var inner_box_left = pushbox_zone_top_left.x
	var inner_box_right = pushbox_zone_bottom_right.x
	var inner_box_top = pushbox_zone_top_left.y
	var inner_box_bottom = pushbox_zone_bottom_right.y
	
	# Boundary checks for the outerbox.
	# Left	
	var diff_between_left_edges_outer = (tpos.x - target.WIDTH / 2.0) - (cpos.x + outer_box_left)
	if diff_between_left_edges_outer < 0:
		global_position.x += diff_between_left_edges_outer
	# Right
	var diff_between_right_edges_outer = (tpos.x + target.WIDTH / 2.0) - (cpos.x + outer_box_right)
	if diff_between_right_edges_outer > 0:
		global_position.x += diff_between_right_edges_outer
	# Top
	var diff_between_top_edges_outer = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + outer_box_top)
	if diff_between_top_edges_outer < 0:
		global_position.z += diff_between_top_edges_outer
	# Bottom
	var diff_between_bottom_edges_outer = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + outer_box_bottom)
	if diff_between_bottom_edges_outer > 0:
		global_position.z += diff_between_bottom_edges_outer
	
	velocity = target.velocity
	var speed = velocity.length()
	# To check if the player is moving. 
	if speed > 0.1:
		var diff_between_left_edges_inner = (tpos.x - target.WIDTH / 2.0) - (cpos.x + inner_box_left)
		if diff_between_left_edges_inner < 0:
			# Since player is moving, not touching the outer box edge, and in between the two boxes 
			# push_ratio is * by speed of the target 
			global_position.x += diff_between_left_edges_inner * push_ratio * delta
	# Right
		var diff_between_right_edges_inner = (tpos.x + target.WIDTH / 2.0) - (cpos.x + inner_box_right)
		if diff_between_right_edges_inner > 0:
			global_position.x += diff_between_right_edges_inner * push_ratio * delta
	# Top
		var diff_between_top_edges_inner = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + inner_box_top)
		if diff_between_top_edges_inner < 0:
			global_position.z += diff_between_top_edges_inner * push_ratio * delta
	# Bottom
		var diff_between_bottom_edges_inner = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + inner_box_bottom)
		if diff_between_bottom_edges_inner > 0:
			global_position.z += diff_between_bottom_edges_inner * push_ratio * delta

	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var outer_box_left = pushbox_top_left.x
	var outer_box_right = pushbox_bottom_right.x
	var outer_box_top = pushbox_top_left.y
	var outer_box_bottom = pushbox_bottom_right.y
	
	var inner_box_left = pushbox_zone_top_left.x
	var inner_box_right = pushbox_zone_bottom_right.x
	var inner_box_top = pushbox_zone_top_left.y
	var inner_box_bottom = pushbox_zone_bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(outer_box_right, 0, outer_box_top))
	immediate_mesh.surface_add_vertex(Vector3(outer_box_right, 0, outer_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(outer_box_right, 0, outer_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(outer_box_left, 0, outer_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(outer_box_left, 0, outer_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(outer_box_left, 0, outer_box_top))
	immediate_mesh.surface_add_vertex(Vector3(outer_box_left, 0, outer_box_top))
	immediate_mesh.surface_add_vertex(Vector3(outer_box_right, 0, outer_box_top))
	
	
	immediate_mesh.surface_add_vertex(Vector3(inner_box_right, 0, inner_box_top))
	immediate_mesh.surface_add_vertex(Vector3(inner_box_right, 0, inner_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_box_right, 0, inner_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_box_left, 0, inner_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_box_left, 0, inner_box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_box_left, 0, inner_box_top))
	immediate_mesh.surface_add_vertex(Vector3(inner_box_left, 0, inner_box_top))
	immediate_mesh.surface_add_vertex(Vector3(inner_box_right, 0, inner_box_top))

	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# Mesh is freed after one update of _process.
	await get_tree().process_frame
	mesh_instance.queue_free()
	
