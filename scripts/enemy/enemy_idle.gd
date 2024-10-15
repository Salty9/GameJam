extends State


@export var loiter_range:float = 50

var initial_position:Vector2
func _ready():
	super._ready()
	initial_position = global_position
	$Timer.timeout.connect(on_timer_timout)
	



func on_timer_timout():
	if not enabled or object_movement_component == null:
		return
	
	var target := initial_position + Vector2(randf_range(-loiter_range,loiter_range),randf_range(-loiter_range,loiter_range))
	object_movement_component.normalized_dir = (target - global_position).normalized()
