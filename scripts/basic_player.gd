extends "res://scripts/character.gd"


func _process(delta: float) -> void:
	$Sprite2D.flip_h = $MovementComponent.normalized_dir.x<0
