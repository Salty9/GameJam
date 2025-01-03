extends DamageSystem
# script should be overriden with extends "scripts/projectile.gd"
# player & enemy projectiles should be on separate physics layers
class_name Projectile
@export var life_time :float = 1
signal destroyed

func _ready()->void:
	can_take_damage = false
	can_deal_damage = true
	super._ready()
	monitorable = true

	no_health_remaining.connect(destroy)
	
	if life_time > 0:
		$Timer.wait_time = life_time
		$Timer.timeout.connect(destroy)


func launch(normalized_direction:Vector2)->void:
	$MovementComponent.normalized_dir = normalized_direction
	global_rotation = normalized_direction.angle()

func on_area_entered(area:Area2D):
	super.on_area_entered(area)
	destroy()
	
func destroy():
	destroyed.emit()
	queue_free()
