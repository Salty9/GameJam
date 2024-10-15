extends State


func enter():
	if object_movement_component != null:
		object_movement_component.normalized_dir = Vector2.ZERO
	super.enter()
