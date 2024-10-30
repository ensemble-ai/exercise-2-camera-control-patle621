class_name LerpSmoothingTargetFocus 
extends CameraControllerBase

@export var vert_cross_length:float = 5.0
@export var horiz_cross_length:float = 5.0

#should be faster than vessel
@export var lead_speed:float = 60.0
@export var catchup_delay_duration:float = 2.0
@export var catchup_speed:float = 5.0
@export var leash_distance:float = 100.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
