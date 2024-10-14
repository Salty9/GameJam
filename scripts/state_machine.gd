extends Node2D

# class should be extended with desired "State" (s) as children

class_name StateMachine

var states:Array[State]

signal state_changed



@export var initial_state:State

var current_state:State=null

var parent:Node2D


func _ready() ->void:
	parent = get_parent()
	for child in get_children():
		if child is State:
			
			var child_state :State= child as State
			child_state.state_exited.connect(on_state_exited)
			child_state.object = parent
			states.append(child_state)
	if initial_state != null:
		change_state(initial_state)

# to be overriden
func on_state_exited(state_name:String)->void:
	# if state_name == $MovementState.name
		# change_state($AttackState)
	pass


func change_state(state:State)->void:
	if current_state == state :
		return
	if current_state != null:
		current_state.exit()
	current_state = state
	current_state.enter()
