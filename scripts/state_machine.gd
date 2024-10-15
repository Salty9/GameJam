extends Node2D

# class should be extended with desired "State" (s) as children

class_name StateMachine

#var states:Array[State]

signal state_changed



@export var initial_state:State

var current_state:State=null

var parent:Node2D

@export var parent_movement_component:MovementComponent


func _ready() ->void:
	parent = get_parent()
	
	var bit_mask:int = 1
	
	for child in get_children():
		if child is State:
			
			var child_state :State= child as State
			child_state.bit_mask = bit_mask
			bit_mask <<= 1
			child_state.state_exited.connect(on_state_exited)
			child_state.object = parent
			child.object_movement_component = parent_movement_component
			#states.append(child_state)
	if initial_state != null:
		change_state(initial_state)

# to be overriden
func on_state_exited(state_name:String)->void:
	# if state_name == $MovementState.name
		# change_state($AttackState)
	pass

func is_in_state(states:Array[State])->bool:
	var bit_mask := 0
	for state in states:
		bit_mask |= state.bit_mask
	return (current_state.bit_mask & bit_mask) != 0

func change_state(state:State)->void:
	if current_state == state :
		return
	if current_state != null:
		current_state.exit()
	current_state = state
	current_state.enter()
