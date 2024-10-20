extends Node2D
signal cooldown_time_changed
@export var cooldown_time :float = 0.6:
	set(value):
		cooldown_time = value
		cooldown_time_changed.emit()

func on_cooldown_time_changed():
	$Timer.wait_time = cooldown_time

func _ready()->void:
	cooldown_time_changed.connect(on_cooldown_time_changed)
	%DamageSystem.disable()
	on_cooldown_time_changed()
	
	

func swing()->void:
	if $Timer.is_stopped():
		GlobalAudioServer.play_audio("res://assets/audio/sword_swing.mp3",global_position)
		
		$AnimationPlayer.play("swing")
		$Timer.start()
