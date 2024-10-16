extends "res://scripts/character.gd"

func _ready()->void:
	$DamageSystem.health_changed.connect(on_health_changed)
	
func on_health_changed(new_health:int)->void:
	$AnimatedSprite2D.material.set_shader_parameter("enabled",true)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("enabled",false)

func _process(delta: float) -> void:
	if $MovementComponent.normalized_dir.x != 0:
		$AnimatedSprite2D.flip_h = $MovementComponent.normalized_dir.x < 0
		$Stick.position.x = -$Stick.position.x if $AnimatedSprite2D.flip_h else $Stick.position.x
