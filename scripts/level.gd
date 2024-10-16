extends Node2D

var dropped_sword_scene:PackedScene = preload("res://scenes/dropped_sword.tscn")
var spawn_locations:Array[Marker2D]

func _ready()->void:
	$BasicPlayer.dead.connect(on_player_death)
	var camera :Camera2D = $BasicPlayer.find_child("Camera2D")
	
	camera.limit_left = $BorderMarkers/TopLeft.global_position.x
	camera.limit_right = $BorderMarkers/TopRight.global_position.x
	camera.limit_top = $BorderMarkers/TopLeft.global_position.y
	camera.limit_bottom = $BorderMarkers/BottomLeft.global_position.y
	
	
	for child in $SpawnMarkers.get_children():
		if child is Marker2D:
			spawn_locations.append(child)

func on_player_death()->void:
	var player_pos :Vector2= $BasicPlayer.global_position
	$BasicPlayer.global_position = spawn_locations.pick_random().global_position
	
	var sword = dropped_sword_scene.instantiate() as Area2D
	sword.global_position = player_pos
	sword.sword_picked_up.connect(on_player_sword_picked_up)

	call_deferred("add_child",sword)
	


func on_player_sword_picked_up()->void:
	$BasicPlayer.add_to_group("player_group")
	
	$BasicPlayer.find_child("Sword").visible = true
	$BasicPlayer.find_child("DamageSystem").reinitialize()
