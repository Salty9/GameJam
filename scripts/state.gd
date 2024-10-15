extends Node2D

# class should be extended
# timer nodes can be used to determine when to exit from this state
# exit() method can be called from the script's _physics_process or _process function when speicific condition triggers
# The parent(StateMachine) should be able figure out how to handle the next steps

class_name State

var object_movement_component:MovementComponent
var object:Node2D
var enabled:bool = false

signal state_exited(state_name:String)

func _ready():
	set_process(false)
	set_physics_process(false)

func enter():
	enabled = true
	set_process(true)
	set_physics_process(true)


func exit():
	enabled = false
	set_process(false)
	set_physics_process(false)
	state_exited.emit(name)
