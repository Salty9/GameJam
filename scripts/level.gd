extends Node2D

var dropped_sword_scene:PackedScene = preload("res://scenes/dropped_sword.tscn")
var spawn_locations:Array[Marker2D]

var checkpoint_count:int=0

func _ready()->void:
	$BasicPlayer.dead.connect(on_player_death)
	var camera :Camera2D = $BasicPlayer.find_child("Camera2D")
	
	camera.limit_left = $BorderMarkers/TopLeft.global_position.x
	camera.limit_right = $BorderMarkers/TopRight.global_position.x
	camera.limit_top = $BorderMarkers/TopLeft.global_position.y
	camera.limit_bottom = $BorderMarkers/BottomLeft.global_position.y
	
	for child in $Checkpoints.get_children():
		if child is DamageSystem:
			checkpoint_count += 1
			child.statue_broken.connect(on_checkpoint_cleared)
	for child in $SpawnMarkers.get_children():
		if child is Marker2D:
			spawn_locations.append(child)
			
func on_checkpoint_cleared()->void:
	checkpoint_count-=1
	if checkpoint_count == 0:
		
		$BasicPlayer.disable_input()
		
		var boss_scene = load("res://scenes/enemy/boss_enemy.tscn")
		
		
		
		var boss_enemy = boss_scene.instantiate()
		boss_enemy.global_position = $BossEnemySpawnMarker.global_position
		
		
		
		call_deferred("add_child",boss_enemy)
		
		
		var player_camera:Camera2D = $BasicPlayer.find_child("Camera2D")
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(player_camera,"global_position",$BossEnemySpawnMarker.global_position,2)
		
		tween.tween_property(player_camera,"global_position",$BasicPlayer.global_position,1)
		tween.finished.connect(func()->void:$BasicPlayer.enable_input())
		

func on_player_death()->void:
	var player_pos :Vector2= $BasicPlayer.global_position
	
	$BasicPlayer.accept_input = false
	$BasicPlayer.hide()
	#$BasicPlayer.global_position = spawn_locations.pick_random().global_position
	
	var tween :Tween = get_tree().create_tween()
	tween.tween_property($BasicPlayer,"global_position",spawn_locations.pick_random().global_position,2)
	
	tween.finished.connect(on_player_respawn)
	
	var sword = dropped_sword_scene.instantiate() as Area2D
	sword.global_position = player_pos
	sword.sword_picked_up.connect(on_player_sword_picked_up)

	call_deferred("add_child",sword)


func on_player_respawn()->void:
	$BasicPlayer.show()
	$BasicPlayer.find_child("MovementComponent").enable()



func on_player_sword_picked_up()->void:
	$BasicPlayer.add_to_group("player_group")
	if $BasicPlayer.enabled_weapon != null:
		$BasicPlayer.enabled_weapon.show()
	$BasicPlayer.find_child("PlayerShield").show()
	$BasicPlayer.find_child("DamageSystem").reinitialize()
	$BasicPlayer.accept_input = true
