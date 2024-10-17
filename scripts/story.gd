

extends Control

signal text_showed
signal story_showed

var allow_next :bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and allow_next:
		text_showed.emit()
	elif Input.is_action_just_pressed("debug"):
		story_showed.emit()

func show_story_line()->void:
	$AudioStreamPlayer.play()
	
	
	for i in range(7):
		
		
		var tween:Tween = get_tree().create_tween()
		tween.tween_property($TextureRect,"modulate:a",1,1)
		
		
		$TextureRect.texture = load("res://assets/posters/poster"+str((i+1)) +".png")
		
		
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
		tween.tween_property($Label,"modulate:a",0,1)
		tween.tween_property($TextureRect,"modulate:a",0,1)
		
		await tween.finished
		tween.stop()
		tween.kill()
	story_showed.emit()


func show_story_text(index:int):
	allow_next = false
	var array = Texts.story_texts[str(index)]
	for i in range(array.size()):
		var tween:Tween = get_tree().create_tween()
		$Label.text = array[i]
		tween.tween_property($Label,"modulate:a",1,1)
		if i < array.size()-1:
			tween.tween_interval(array[i].length()/10.0)
			tween.tween_property($Label,"modulate:a",0,1)
		await tween.finished
		tween.stop()
		tween.kill()
	allow_next = true
	$Label.modulate.a = 1
