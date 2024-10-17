extends DamageSystem

signal statue_broken





func _ready()->void:
	super._ready()
	no_health_remaining.connect(on_statue_broken)
	health_bar.show()



func on_statue_broken()->void:
	GlobalAudioServer.play_audio("res://assets/audio/fountain_broking.wav",global_position)
	$Sprite2D.show()
	statue_broken.emit()
	health_bar.hide()
