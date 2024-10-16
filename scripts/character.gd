extends CharacterBody2D
class_name Character
# script should be extended like this:
# extends "scripts/character.gd"

signal dead


# if overriden, function must begin with super._ready() call
func _ready()->void:
	$DamageSystem.no_health_remaining.connect(die)


# should be overriden with super.die() call at the end
func die():
	dead.emit()
	queue_free()
