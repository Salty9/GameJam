extends "res://scripts/projectile.gd"
const audio_paths = ["res://assets/audio/fireball-whoosh-1.mp3","res://assets/audio/fireball-whoosh-2.mp3"]

func _ready()->void:
	super._ready()
	GlobalAudioServer.play_audio(audio_paths.pick_random(),global_position)
