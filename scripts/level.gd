extends Node2D
signal entering_boss_fight
var dropped_sword_scene:PackedScene = preload("res://scenes/dropped_sword.tscn")


var checkpoint_count:int=0

@export var boss_scene:PackedScene

var axe_bonus_array:Array[int]=[1]

func _ready()->void:
	$BasicPlayer.dead.connect(on_player_death)
	$BasicPlayer.level2 = "2" in name
	
	var camera :Camera2D = $BasicPlayer.find_child("Camera2D")
	
	camera.limit_left = $BorderMarkers/TopLeft.global_position.x
	camera.limit_right = $BorderMarkers/TopRight.global_position.x
	camera.limit_top = $BorderMarkers/TopLeft.global_position.y
	camera.limit_bottom = $BorderMarkers/BottomLeft.global_position.y
	
	for child in $Checkpoints.get_children():
		if child is DamageSystem:
			checkpoint_count += 1
			child.statue_broken.connect(on_checkpoint_cleared)
			
			for enemy in child.get_children():
				if enemy is Character and enemy.is_in_group("enemy_group"):
					enemy.dead.connect(on_enemy_dead)
					
					

	if not $BasicPlayer.level2:
		$BasicPlayer.show_tutorial()
		
func on_enemy_dead()->void:
	var bonus :int= axe_bonus_array.pick_random()
	$BasicPlayer.find_child("Axe").max_count += bonus
	if bonus == 1:
		axe_bonus_array.append(0)
	
	
	
func on_checkpoint_cleared()->void:
	checkpoint_count-=1
	if checkpoint_count == 0:
		
		$BasicPlayer.disable_input()
		if boss_scene == null:
			return
		entering_boss_fight.emit()
		
		
		
		
		var boss_enemy = boss_scene.instantiate()
		boss_enemy.global_position = $BossEnemySpawnMarker.global_position
		
		
		
		call_deferred("add_child",boss_enemy)
		
		
		var player_camera:Camera2D = $BasicPlayer.find_child("Camera2D")
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(player_camera,"global_position",$BossEnemySpawnMarker.global_position,2)
		
		tween.tween_property(player_camera,"global_position",$BasicPlayer.global_position,1)
		tween.finished.connect(boss_revealed)
func boss_revealed()->void:
	$BasicPlayer.enable_input()
	for child in get_children():
		if child is AudioPlayer:
			child.stop()
	$AudioStream.stop()
	$AudioStream.stream = load("res://assets/audio/boss-fight60s.mp3")
	$AudioStream.play()
	

func on_player_death()->void:
	var player_pos :Vector2= $BasicPlayer.global_position
	
	$BasicPlayer.accept_input = false
	$BasicPlayer.hide()
	#$BasicPlayer.global_position = spawn_locations.pick_random().global_position
	
	var tween :Tween = get_tree().create_tween()
	tween.tween_property($BasicPlayer,"global_position",$SpawnMarker.global_position,2)
	
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
