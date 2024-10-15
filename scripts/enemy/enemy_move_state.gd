extends State




func _physics_process(delta: float) -> void:
	if object_movement_component == null:
		return
	object_movement_component.normalized_dir = (get_tree().get_first_node_in_group("player_group").global_position - global_position).normalized()
	
