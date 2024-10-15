extends "res://scripts/character.gd"


func _process(delta: float) -> void:
	if $MovementComponent.normalized_dir.x != 0:
		$AnimatedSprite2D.flip_h = $MovementComponent.normalized_dir.x<0
	if Input.is_action_just_pressed("attack") and $Sword.visible:
		$Sword.swing()

	$Sword.look_at(get_global_mouse_position())
	$Sword.scale.y = -1 if $Sword.global_rotation >2 and $Sword.global_rotation >-2 else 1


func die():
	$DamageSystem.disable()
	$Sword.visible = false
	remove_from_group("player_group")
	dead.emit()
	
