extends "res://scripts/character.gd"

var enabled_weapon

func _ready()->void:
	$DamageSystem.health_changed.connect(on_health_changed)
	
	
	
func on_health_changed(_new_health:int):
	$AnimatedSprite2D.material.set_shader_parameter("enabled",true)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("enabled",false)

func _process(delta: float) -> void:
	if $MovementComponent.normalized_dir.x != 0:
		$AnimatedSprite2D.flip_h = $MovementComponent.normalized_dir.x<0
	if Input.is_action_just_pressed("attack") :
		if $Sword.visible:
			$Sword.swing()
		elif $Axe.visible:
			$Axe.throw((get_global_mouse_position() - global_position).normalized())
	

	$Sword.look_at(get_global_mouse_position())
	$Sword.scale.y = -1 if $Sword.global_rotation >2 and $Sword.global_rotation >-2 else 1
	
	$Axe.look_at(get_global_mouse_position())
	$Axe.scale.y = -1 if $Axe.global_rotation >2 and $Axe.global_rotation >-2 else 1


func die():
	$DamageSystem.disable()
	$Sword.visible = false
	remove_from_group("player_group")
	dead.emit()
	
