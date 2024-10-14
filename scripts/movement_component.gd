extends Node2D

# for moving entities: player, enemies, projectiles
# class should be extended into node specific child (CharacterBody2D's child Node2D with a script extending this class)
# modify the normalized_dir according to input/behaviour of the entity into the extended class
# call the super class's _physics_process with super._physics_process(delta) from the extended class
# or override the _process() function to control the movement (take input)

class_name MovementComponent

# for a projectile the acceleration should be very high to make the change feel instant
# normalized_dir's magnitude/length can be either 1 or 0

@export var acceleration:int
@export var max_speed:int
@export var friction:int

var velocity:=Vector2.ZERO
var normalized_dir:Vector2=Vector2.ZERO

var parent:Node2D

func _ready() -> void:
	parent = get_parent()
	
func _physics_process(delta):
	if normalized_dir.length_squared()==0:
		velocity = velocity.move_toward(Vector2.ZERO,friction * delta)
	else:
		velocity = velocity.move_toward(normalized_dir * max_speed,acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	if parent is CharacterBody2D:
		parent.velocity = velocity
		parent.move_and_slide()
	else:
		parent.global_position += velocity * delta
		
func disable()->void:
	set_physics_process(false)
