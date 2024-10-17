extends Control


func show_final_poster()->void:
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",1,2)
	await tween.finished
	tween.stop()
	tween.kill()
	for text in Texts.story_texts["7"]:
		var text_tween :Tween = get_tree().create_tween()
		text_tween.tween_property($Label,"modulate:a",1,1)
		text_tween.tween_interval(text.length()/10.0)
		text_tween.tween_property($Label,"modulate:a",0,1)
		await text_tween.finished
		text_tween.stop()
		text_tween.kill()
