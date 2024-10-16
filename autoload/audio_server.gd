extends Node


func play_audio(path:String, position:Vector2)->void:
	var audio_player:AudioPlayer=AudioPlayer.new()
	audio_player.stream = load(path)
	audio_player.global_position = position
	get_tree().get_first_node_in_group("level").call_deferred("add_child",audio_player)
	await audio_player.ready
	audio_player.play()
