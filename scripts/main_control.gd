

extends Control
@onready var json_dict = JSON.parse_string(FileAccess.get_file_as_string("res://data/story_separated.json"))

signal text_showed
signal story_showed

func show_story_line()->void:
	$AudioStreamPlayer.play()
	
	
	for i in range(7):
		
		
		var tween:Tween = get_tree().create_tween()
		tween.tween_property($TextureRect,"modulate:a",1,1)
		
		
		$TextureRect.texture = load("res://test/poster"+str((i+1)) +".png")
		
		
		#for j in range(json_dict[str(i)].size()):
			#$Label.text = json_dict[str(i)][j]
			#tween.tween_property($Label,"modulate:a",1,1)
			#tween.tween_interval(json_dict[str(i)][j].length()/10.0)
			#tween.tween_property($Label,"modulate:a",0,1.5)
			#await tween.finished
		await tween.finished
		show_story_text(i)
		await text_showed
		tween.stop()
		tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property($TextureRect,"modulate:a",0,2)
		await tween.finished
		tween.stop()
		tween.kill()
	story_showed.emit()


func show_story_text(index:int):
	var array = json_dict[str(index)]
	for i in range(array.size()):
		var tween:Tween = get_tree().create_tween()
		$Label.text = array[i]
		tween.tween_property($Label,"modulate:a",1,1)
		tween.tween_interval(array[i].length()/10.0)
		tween.tween_property($Label,"modulate:a",0,1.5)
		await tween.finished
		tween.stop()
		tween.kill()
	text_showed.emit()
