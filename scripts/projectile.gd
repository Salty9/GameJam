extends DamageSystem
# script should be overriden with extends "scripts/projectile.gd"
# player & enemy projectiles should be on separate physics layers
func _ready()->void:
	can_take_damage = true
	can_deal_damage = true
	max_health = 1
	super._ready()

	no_health_remaining.connect(destroy)

func launch(normalized_direction:Vector2)->void:
	$MovementComponent.normalized_dir = normalized_direction

	
func destroy():
	queue_free()
