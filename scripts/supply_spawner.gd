extends Node2D


@export var supplies:Array[PackedScene]

var spawn_locations:Array[Marker2D]

@export var null_counter:int =3

func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)
	
	for child in $SpawnMarkers.get_children():
		if child is Marker2D:
			spawn_locations.append(child)
	for i in range(null_counter):
		supplies.append(null)
	get_parent().entering_boss_fight.connect(on_entering_boss_fight)
	
func on_entering_boss_fight()->void:
	$Timer.start()
	
func on_timer_timeout()->void:
	spawn_supply()
	$Timer.wait_time *= 1.7
	

func spawn_supply()->void:
	if supplies.is_empty():
		return
		
	var supply_scene = supplies.pick_random()
	if supply_scene == null:
		$Timer.start()
		return
	var supply = supply_scene.instantiate()
	supply.global_position = spawn_locations.pick_random().global_position
	
	get_parent().add_child(supply)
	supply.tree_exiting.connect(func ()->void:$Timer.start())
