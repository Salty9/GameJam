extends State

var player:Character

@export var attack_range:float = 50

func _ready()->void:
	player = get_tree().get_first_node_in_group("player_group")
	

func _physics_process(delta: float) -> void:
	if object_movement_component == null :
		return
		
	if player == null:
		exit()
	
	var distance_vec:=player.global_position - global_position
	object_movement_component.normalized_dir = distance_vec.normalized()
	
	if distance_vec.length_squared() < attack_range:
		exit()
		
