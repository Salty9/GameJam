extends "res://scripts/projectile.gd"
@export var swing_time:float = 2

var coming_back:bool = false
var character:Character
var pickup_radius:int = 50

func _ready()->void:
	life_time = -1
	super._ready()
	$TravelTimer.timeout.connect(on_travel_timer_timeout)

func start(thrower:Character,total_travel_time:float)->void:
	character = thrower
	$TravelTimer.wait_time = total_travel_time / 2.0
	$TravelTimer.start()

func _process(delta: float) -> void:
	$Sprite2D.rotate(PI/4)

func _physics_process(delta: float) -> void:
	
	if character == null:
		destroy()
	elif coming_back:
		$MovementComponent.normalized_dir = (character.global_position - global_position).normalized()


func on_travel_timer_timeout():
	coming_back = true
	$MovementComponent.acceleration/=2.0
	
