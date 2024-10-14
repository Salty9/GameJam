extends CharacterBody2D

# script should be extended like this:
# extends "scripts/character.gd"

signal dead


# if overriden, function must begin with super._ready() call
func _ready()->void:
	$DamageSystem.no_health_remaining.connect(die)


# should be overriden with super.die() call at the end
func die():
	queue_free()
