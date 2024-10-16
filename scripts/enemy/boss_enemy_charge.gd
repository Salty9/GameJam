extends State


@export var charge_time:float = 3

var prev_acceleration:int

func _ready()->void:
	$Timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	if not enabled or object_movement_component == null:
		return
	var player:Character = get_tree().get_first_node_in_group("player_group")
	if player == null:
		exit()
		return
	
	object_movement_component.normalized_dir = (player.global_position - global_position).normalized()

func enter():
	super.enter()
	$Timer.wait_time = charge_time
	if object_movement_component != null:
		prev_acceleration = object_movement_component.acceleration
		object_movement_component.acceleration = prev_acceleration * 2

func exit()->void:
	super.exit()
	if object_movement_component != null:
		object_movement_component.acceleration = prev_acceleration
