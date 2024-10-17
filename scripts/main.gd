extends Node

var loaded_level:Node2D
var loaded_level_index:int
const levels = [preload("res://scenes/level_1.tscn"),preload("res://scenes/level_2.tscn")]

func _ready()->void:
	$TitleScreen.blink_label()
	$TitleScreen.key_pressed.connect(on_title_screen_key_pressed)


	
func on_title_screen_key_pressed()->void:
	$TitleScreen.queue_free()
	$Story.show_story_line()
	$Story.story_showed.connect(on_story_showed)

func on_story_showed()->void:
	$Story.queue_free()
	load_level(0)

func load_level(level_index:int=0)->void:
	loaded_level_index = level_index
	if loaded_level != null:
		loaded_level.queue_free()
	var level = levels[level_index].instantiate()
	
	level.modulate.a = 0
	level.level_complete.connect(on_level_complete)
	
	call_deferred("add_child",level)
	loaded_level = level
	var tween :Tween = get_tree().create_tween()
	tween.tween_property(level,"modulate:a",1,1)
	await tween.finished
	tween.stop()
	tween.kill()
	

func on_level_complete()->void:
	if loaded_level != null:
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(loaded_level,"modulate:a",0,2)
		await tween.finished
		tween.stop()
		tween.kill()
	if loaded_level_index == 0:
		
		
		$LevelTransition.show_transition()
		$LevelTransition.key_pressed.connect(on_level_transition_showed)
	else:
		$Final.show_final_poster()


func on_level_transition_showed()->void:
	$LevelTransition.queue_free()
	load_level(1)
