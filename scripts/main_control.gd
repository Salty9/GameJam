extends Control


func _ready():
	show_story_line()

func show_story_line()->void:
	var json_array = JSON.parse_string(FileAccess.get_file_as_string("res://data/story.json"))
	for i in range(7):
		var tween:Tween = get_tree().create_tween()
		tween.tween_property($TextureRect,"modulate:a",1,1)
		await tween.finished
		tween.stop()
		
		$TextureRect.texture = load("res://test/poster"+str((i+1)) +".png")
		$Label.modulate.a = 0.0
		
		
		$Label.text = json_array[i]
		tween.tween_property($Label,"modulate:a",1,1)
		await tween.finished
		tween.stop()
		
		await get_tree().create_timer(json_array[i].length()/90.0).timeout

		tween.tween_property($Label,"modulate:a",0,1.5)
		await tween.finished
		tween.stop()
		
		tween.tween_property($TextureRect,"modulate:a",0,2)
		await tween.finished
		tween.stop()
