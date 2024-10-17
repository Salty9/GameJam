extends Area2D

signal sword_picked_up

func _ready()->void:
	
	await get_tree().create_timer(1).timeout
	body_entered.connect(on_body_entered)
	
	#var tween :Tween = get_tree().create_tween()
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property($Sprite2D,"position:y",$Sprite2D.position.y - 10, 0.8)
	#
	#tween.tween_property($Sprite2D,"position:y",$Sprite2D.position.y + 10, 0.8)
	#tween.set_loops()

	
func on_body_entered(body:CharacterBody2D)->void:
	GlobalAudioServer.play_audio("res://assets/audio/Pickup.wav",global_position)
	sword_picked_up.emit()
	queue_free()
