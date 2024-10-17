extends Character


func _ready()->void:
	super._ready()
	$DamageSystem.took_damage.connect(on_took_damage)
	
func on_took_damage(damage)->void:
	$AnimatedSprite2D.material.set_shader_parameter("flash",true)
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.material.set_shader_parameter("flash",false)
	if $DamageSystem.health != 0:
		GlobalAudioServer.play_audio("res://assets/audio/boss_grunt.wav",global_position)


func die()->void:
	
	GlobalAudioServer.play_audio("res://assets/audio/boss_dead.wav",global_position)
	super.die()
