extends "res://scripts/player/basic_player.gd"


func _process(delta: float) -> void:
	super._process(delta)
	if  Input.is_action_just_pressed("attack")and accept_input  :
		if $Sword.visible:
			$Sword.swing()
		elif $Axe.visible:
			$Axe.throw((get_global_mouse_position() - global_position).normalized())
	elif Input.is_action_just_pressed("weapon_1") and accept_input:
		enabled_weapon = $Sword
	elif Input.is_action_just_pressed("weapon_2") and accept_input :
		enabled_weapon = $Axe
	
	$Axe.look_at(get_global_mouse_position())
	$Axe.scale.y = -1 if $Axe.global_rotation >2 and $Axe.global_rotation >-2 else 1
