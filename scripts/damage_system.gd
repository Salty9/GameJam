extends Area2D

# all entities (characters) should have at least one DamageSystem node as child
# projectiles should inherit from DamageSystem
# projectiles should have max_health set to 1 and also be able to take_damage
# parent of this node should utilize the dead() signal for handling object's end of life

class_name DamageSystem
signal health_changed(new_health:int)
signal took_damage(damage_taken:int)
signal no_health_remaining

var is_dead:bool =false

@export var can_take_damage:bool=true:
	set(value):
		monitorable = value
		can_take_damage = value
@export var can_deal_damage:bool = true:
	set(value):
		monitoring = value
		can_deal_damage = value

@export var max_health :int

var health:int:
	set(value):
		
		var new_health = min(max(0,value),max_health)
		if new_health != health:
			
			health_changed.emit(new_health)
			health = new_health
		


@export var damage:int

func _ready()->void:
	health = max_health
	area_entered.connect(on_area_entered)
	monitorable = can_take_damage
	monitoring = can_deal_damage


func on_area_entered(area:Area2D)->void:
	if not area is DamageSystem:
		return
	if can_deal_damage and area.can_take_damage:
		area.take_damage(damage)
	
func take_damage(damage_to_be_dealt:int) -> void:
	health -= damage_to_be_dealt
	
	if damage_to_be_dealt > 0:
		took_damage.emit(damage_to_be_dealt)
	
	if  health == 0 and not is_dead:
		no_health_remaining.emit()
		is_dead = true
	
	
func reinitialize()->void:
	enable()
	health = max_health
	is_dead = false

func disable()->void:
	set_physics_process(false)
	set_process(false)
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.set_deferred("disabled",true)

func enable()->void:
	set_physics_process(true)
	set_process(true)
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.set_deferred("disabled",false)
