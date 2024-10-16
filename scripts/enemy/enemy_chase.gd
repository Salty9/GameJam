extends State






func _physics_process(delta: float) -> void:
	if object_movement_component == null :
		return
	var player :Character = get_tree().get_first_node_in_group("player_group")
	if player == null:
		exit()
		return
	
	var distance_vec:=player.global_position - global_position
	object_movement_component.normalized_dir = distance_vec.normalized()
