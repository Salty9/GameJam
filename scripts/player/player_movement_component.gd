extends MovementComponent


func get_move_direction() -> Vector2:
	var direction:Vector2
	direction.x = Input.get_axis("ui_left","ui_right")
	direction.y = Input.get_axis("ui_up","ui_down")
	return direction.normalized()

func _process(delta:float)->void:
	normalized_dir = get_move_direction()
	
