extends Control


func show_final_poster()->void:
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.finished.connect($AudioStreamPlayer.play)
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",1,2)
	await tween.finished
	tween.stop()
	tween.kill()
	for i in range( Texts.story_texts["7"].size()):
		var text  = Texts.story_texts["7"][i]
		var text_tween :Tween = get_tree().create_tween()
		$Label.text = text
		text_tween.tween_property($Label,"modulate:a",1,1)
		text_tween.tween_interval(text.length()/10.0)
		if i <  Texts.story_texts["7"].size()-1:
			text_tween.tween_property($Label,"modulate:a",0,1)
		await text_tween.finished
		text_tween.stop()
		text_tween.kill()
