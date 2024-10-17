extends StateMachine


@export var attack_range:int = 500

func _physics_process(delta: float) -> void:
	
	var player :Character = get_tree().get_first_node_in_group("player_group")
	if player == null:
		return
		
	var dist_sq: = (player.global_position - global_position).length()
	
	if current_state == $Attack:
		if dist_sq> attack_range:
			print("should charge")
			change_state($Charge)
	elif current_state == $Charge:
		if dist_sq < attack_range :
			print("should attack")
			change_state($Attack)


func on_state_exited(state_name:String)->void:
	if state_name == $Attack.name :
		$"../AnimatedSprite2D".material.set_shader_parameter("enalbled",false)
	else:
		$"../AnimatedSprite2D".material.set_shader_parameter("enalbled",true)
