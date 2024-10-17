extends Character


func _ready()->void:
	super._ready()
	$DamageSystem.health_changed.connect(on_health_changed)
	
func on_health_changed(_new_health)->void:
	$AnimatedSprite2D.material.set_shader_parameter("flash",true)
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.material.set_shader_parameter("flash",false)
