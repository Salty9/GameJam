extends State


var fireball_scene:PackedScene = preload("res://scenes/fireball.tscn")

signal cooldown_time_changed

var player:Character

@export var cooldown_time :float = 1:
	set(value):
		cooldown_time = value
		cooldown_time_changed.emit()
		
func enter():
	if object_movement_component != null:
		object_movement_component.normalized_dir = Vector2.ZERO
	super.enter()

func _ready():
	super._ready()
	player = get_tree().get_first_node_in_group("player_group")
	cooldown_time_changed.connect(on_cooldown_time_changed)
	on_cooldown_time_changed()
	$Timer.timeout.connect(on_timer_timeout)
	
func on_cooldown_time_changed():
	$Timer.wait_time = cooldown_time

func on_timer_timeout():
	if enabled and player != null:
		launch_fireball()
	
func launch_fireball():
	
	var direction:Vector2 = (player.global_position - global_position).normalized()
	var launch_location:Vector2 = direction * 10
	var fireball = fireball_scene.instantiate()
	fireball.global_position = launch_location + global_position
	fireball.launch(direction)
	get_tree().root.get_child(0).add_child(fireball)
	
