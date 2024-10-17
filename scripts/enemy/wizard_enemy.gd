extends "res://scripts/character.gd"

func _ready()->void:
	super._ready()
	$DamageSystem.took_damage.connect(on_took_damage)
	
	
func on_took_damage(damage_taken:int)->void:
	if $DamageSystem.health != 0:
		GlobalAudioServer.play_audio("res://assets/audio/enemy_grunt.wav",global_position)
	
	$AnimatedSprite2D.material.set_shader_parameter("enabled",true)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("enabled",false)

func _process(delta: float) -> void:
	if $MovementComponent.normalized_dir.x != 0:
		$AnimatedSprite2D.flip_h = $MovementComponent.normalized_dir.x < 0
		$Stick.position.x = -$Stick.position.x if $AnimatedSprite2D.flip_h else $Stick.position.x


func die()->void:

	GlobalAudioServer.play_audio("res://assets/audio/enemy_dead2.wav",global_position)
	super.die()
