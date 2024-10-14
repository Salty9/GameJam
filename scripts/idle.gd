extends State
@export var movement_component:MovementComponent

func enter():
	if movement_component != null:
		movement_component.normalized_dir = Vector2.ZERO
	super.enter()
