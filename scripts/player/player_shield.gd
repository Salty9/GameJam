extends Node2D

signal defended
signal defense_timeout

@export var defense_time:float = 0.5



@export var cooldown_time:float = 2




func _ready() -> void:
	$Timer.wait_time = cooldown_time
	$DefenseTimer.wait_time = defense_time
	$DefenseTimer.timeout.connect(on_defense_timer_timeout)
	
	$Sprite2D/DamageSystem.took_damage.connect(on_shield_took_damage)
func on_shield_took_damage(damage:int):
	if not $DefenseTimer.is_stopped():
		$Sprite2D/CPUParticles2D.emitting=true

func defend()->void:
	if $Timer.is_stopped():
		$Sprite2D/DamageSystem.enable()
		$Cosmetic.hide()
		look_at(get_global_mouse_position())
		$Sprite2D.show()
		$DefenseTimer.start()
		defended.emit()
		
		
func on_defense_timer_timeout():
	$Sprite2D.hide()
	$Sprite2D/DamageSystem.disable()
	$Cosmetic.show()
	rotation = 0
	$Timer.start()
	defense_timeout.emit()
