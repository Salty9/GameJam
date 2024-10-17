extends Node2D
signal entering_boss_fight
var dropped_sword_scene:PackedScene = preload("res://scenes/dropped_sword.tscn")

signal level_complete
var checkpoint_count:int=0

@export var boss_scene:PackedScene

@export var player:Character

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		level_complete.emit()

func _ready()->void:
	player.dead.connect(on_player_death)

	
	var camera :Camera2D = player.find_child("Camera2D")
	
	camera.limit_left = $BorderMarkers/TopLeft.global_position.x
	camera.limit_right = $BorderMarkers/TopRight.global_position.x
	camera.limit_top = $BorderMarkers/TopLeft.global_position.y
	camera.limit_bottom = $BorderMarkers/BottomLeft.global_position.y
	
	for child in $Checkpoints.get_children():
		if child is DamageSystem:
			checkpoint_count += 1
			child.statue_broken.connect(on_checkpoint_cleared)
			

func on_checkpoint_cleared()->void:
	checkpoint_count-=1
	if checkpoint_count == 0:
		
		player.disable_input()
		if boss_scene == null:
			level_complete.emit()
			return
		entering_boss_fight.emit()
		
		
		
		
		var boss_enemy = boss_scene.instantiate()
		boss_enemy.global_position = $BossEnemySpawnMarker.global_position
		
		
		boss_enemy.dead.connect(on_boss_dead)
		call_deferred("add_child",boss_enemy)
		
		
		var player_camera:Camera2D = player.find_child("Camera2D")
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(player_camera,"global_position",$BossEnemySpawnMarker.global_position,2)
		tween.tween_interval(1)
		tween.tween_property(player_camera,"global_position",player.global_position,1)
		tween.finished.connect(boss_revealed)
func boss_revealed()->void:
	player.enable_input()
	for child in get_children():
		if child is AudioPlayer:
			child.stop()
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = load("res://assets/audio/boss-fight60s.mp3")
	$AudioStreamPlayer.play()
	

func on_player_death()->void:
	var player_pos :Vector2= player.global_position
	
	player.accept_input = false
	player.hide()
	#player.global_position = spawn_locations.pick_random().global_position
	
	var tween :Tween = get_tree().create_tween()
	tween.tween_property(player,"global_position",$SpawnMarker.global_position,2)
	
	tween.finished.connect(on_player_respawn)
	
	var sword = dropped_sword_scene.instantiate() as Area2D
	sword.global_position = player_pos
	sword.sword_picked_up.connect(on_player_sword_picked_up)

	call_deferred("add_child",sword)


func on_player_respawn()->void:
	player.show()
	player.find_child("MovementComponent").enable()



func on_player_sword_picked_up()->void:
	player.add_to_group("player_group")
	if player.enabled_weapon != null:
		player.enabled_weapon.show()
	player.find_child("PlayerShield").show()
	player.find_child("DamageSystem").reinitialize()
	player.accept_input = true

func on_boss_dead()->void:
	level_complete.emit()
