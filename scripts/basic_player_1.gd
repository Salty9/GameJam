extends "res://scripts/player/basic_player.gd"


func _ready()->void :
	super._ready()
	dead.connect(on_player_dead)
	show_tutorial()
	

func on_player_dead()->void:
	if died == 1:
		await get_tree().create_timer(2).timeout
		%TutorialLabel.text = "return and reclaim the fallen weapon"
		%TutorialLabel.show()
		%TutorialLabel.modulate.a = 0
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(%TutorialLabel,"modulate:a",1,1)
		
		tween.tween_interval(1)
		
		tween.tween_property(%TutorialLabel,"modulate:a",0,1)
		await tween.finished
		
		
		tween.stop()
		
		tween.kill()
		
		
		%TutorialLabel.hide()
		

func _process(delta: float) -> void:
	super._process(delta)
	if  Input.is_action_just_pressed("attack")and accept_input  :
		if $Sword.visible:
			$Sword.swing()

func show_tutorial()->void:

	%TutorialLabel.show()
	%TutorialLabel.modulate.a = 0
	for tutorial in Texts.tutorial_texts:
		%TutorialLabel.text = tutorial
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(%TutorialLabel,"modulate:a",1,1)
		
		tween.tween_interval(1)
		
		tween.tween_property(%TutorialLabel,"modulate:a",0,1)
		await tween.finished
		
		
		tween.stop()
		
		tween.kill()
		
		
	%TutorialLabel.hide()
