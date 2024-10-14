extends StateMachine


func _on_player_detect_radius_body_entered(body: Node2D) -> void:
	change_state($Move)


func _on_player_detect_radius_body_exited(body: Node2D) -> void:
	change_state($Idle)
