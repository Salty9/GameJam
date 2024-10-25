extends "res://scripts/character.gd"

signal died_count_changed
var died:int:
	set(value):
		died = value
		died_count_changed.emit()

var accept_input:bool =true
var enabled_weapon:Node2D:
	set(value):
		if enabled_weapon != null:
			enabled_weapon.hide()
		enabled_weapon = value
		enabled_weapon.show()

func _ready()->void:
	super._ready()
	$DamageSystem.health_changed.connect(on_health_changed)
	$PlayerShield.defended.connect(on_player_defense)
	$PlayerShield.defense_timeout.connect(on_player_defense_timeout)
	enabled_weapon = $Sword
	died_count_changed.connect(on_died_count_changed)
	died = 0

func on_died_count_changed()->void:
	%DeathCountLabel.text = "heroes fallen: "+str(died)

func on_player_defense_timeout():
	enabled_weapon.show()
func on_player_defense():
	enabled_weapon.hide()
	
func disable_input():
	$MovementComponent.disable()
	accept_input=false
func enable_input():
	$MovementComponent.enable()
	accept_input=true

func on_health_changed(_new_health:int):
	$AnimatedSprite2D.material.set_shader_parameter("enabled",true)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("enabled",false)

func _process(delta: float) -> void:
	if $MovementComponent.normalized_dir.x != 0:
		$AnimatedSprite2D.flip_h = $MovementComponent.normalized_dir.x<0
	
			
	elif Input.is_action_just_pressed("defend")and accept_input :
		$PlayerShield.defend()
	#elif Input.is_action_just_pressed("weapon_1") and accept_input and level2:
		#enabled_weapon = $Sword
	#elif Input.is_action_just_pressed("weapon_2") and accept_input and level2:
		#enabled_weapon = $Axe

	$Sword.look_at(get_global_mouse_position())
	$Sword.scale.y = -1 if $Sword.global_rotation >2 and $Sword.global_rotation >-2 else 1
	
	


func die():
	$AnimatedSprite2D.material.set_shader_parameter("enabled",false)
	died += 1
	
	GlobalAudioServer.play_audio("res://assets/audio/player_dead.wav",global_position)
	
	dead.emit()
	$MovementComponent.disable()
	$DamageSystem.disable()
	enabled_weapon.hide()
	$PlayerShield.hide()
	remove_from_group("player_group")
	
