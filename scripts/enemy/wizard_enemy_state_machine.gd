extends StateMachine

var player:Character

@export var player_detect_radius:float = 100
@export var attack_range:float = 50
@export var retreat_if_exceeds:float = 300
@export var checkpoint_range:float = 10

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player_group")
	super._ready()
	

func _physics_process(delta: float) -> void:
	
	
	if player == null:
		return
	var dist := (player.global_position - global_position).length()
	
	if current_state != null:
		print(current_state.name,dist)
		
	if current_state == $Idle :
		if dist < player_detect_radius:
			change_state($Chase)
	elif current_state == $Chase:
		if (global_position - $Retreat.initial_position).length() > retreat_if_exceeds:
			change_state($Retreat)
		elif dist < attack_range:
			change_state($Attack)
		
	elif current_state == $Attack:
		if dist > attack_range :
			change_state($Chase)
	elif current_state == $Retreat:
		if (global_position - $Retreat.initial_position).length() < checkpoint_range:
			change_state($Idle)
	
