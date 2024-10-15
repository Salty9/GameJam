extends State


var initial_position:Vector2

func _ready()->void:
	initial_position = global_position
	super._ready()

func _physics_process(delta: float) -> void:
	if object_movement_component == null:
		return
	var distance_vec := (initial_position - global_position)
	object_movement_component.normalized_dir = distance_vec.normalized()
	if distance_vec.length_squared() < 10:
		exit()