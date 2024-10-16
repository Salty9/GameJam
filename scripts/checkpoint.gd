extends DamageSystem

signal statue_broken

var enemy_count:int =0



func _ready()->void:
	super._ready()
	disable()
	no_health_remaining.connect(on_statue_broken)
	for child in get_children():
		if child is Character and child.is_in_group("enemy_group"):
			child.dead.connect(on_enemy_dead)
			enemy_count += 1

func on_enemy_dead():
	enemy_count -= 1
	if enemy_count == 0:
		enable()

func on_statue_broken()->void:
	$Sprite2D.show()
	statue_broken.emit()
