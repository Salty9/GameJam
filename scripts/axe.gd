extends Node2D

@export var max_count:int = 1
@export var axe_pickup_radius:int = 50

signal axe_count_changed
signal thrown(thrown_axe)

var thrown_axe=null

var throwable_axe_scene:PackedScene = preload("res://scenes/throwable_axe.tscn")



var axe_count:int:
	set(value):
		var prev = axe_count
		axe_count = max(0,min(value,max_count))
		if prev != axe_count:
			axe_count_changed.emit(axe_count)


signal cooldown_time_changed
@export var cooldown_time :float = 0.6:
	set(value):
		cooldown_time = value
		cooldown_time_changed.emit()

func on_cooldown_time_changed():
	$Timer.wait_time = cooldown_time

func _ready()->void:
	cooldown_time_changed.connect(on_cooldown_time_changed)
	on_cooldown_time_changed()
	axe_count = max_count
	axe_count_changed.connect(on_axe_count_changed)
	thrown.connect(on_axe_thrown)
	($Area2D/CollisionShape2D.shape as CircleShape2D).radius = axe_pickup_radius
	$Area2D.area_exited.connect(on_axe_area_exited)
	$Area2D.area_entered.connect(on_axe_area_entered)
	if not get_parent().is_in_group("player_group"):
		$Area2D.set_collision_mask_value(3,true)
		$Area2D.set_collision_layer_value(4,false)

func on_axe_area_exited(area:Area2D):
	thrown_axe = area
func on_axe_area_entered(area:Area2D):
	if thrown_axe == null:
		return
	thrown_axe.destroy()
	thrown_axe = null
	axe_count += 1


func on_axe_thrown(axe)->void:
	axe_count -= 1


func on_axe_count_changed(_new_value:int):
	$Pivot/Sprite2D.visible = axe_count > 0

	
func throw(normalized_direction:Vector2):
	if not $Timer.is_stopped():
		return
	
	var throwable = throwable_axe_scene.instantiate()

	throwable.global_position = $Pivot/Sprite2D.global_position + $Pivot/Sprite2D.offset
	
	get_tree().get_first_node_in_group("level").add_child(throwable)
	
	throwable.launch(normalized_direction)
	
	
	
	if get_parent().is_in_group("player_group"):
		throwable.set_collision_layer_value(4,true)
		throwable.set_collision_mask_value(2,true)
	else:
		throwable.set_collision_layer_value(3,true)
		throwable.set_collision_mask_value(1,true)
		
	throwable.start(get_parent(),4.0)
	thrown.emit(throwable)
	$Timer.start()
