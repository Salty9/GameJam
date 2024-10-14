extends State

@export var movement_component:MovementComponent


func _physics_process(delta: float) -> void:
	if movement_component == null:
		return
	movement_component.normalized_dir = (get_tree().get_first_node_in_group("player_group").global_position - global_position).normalized()
	
