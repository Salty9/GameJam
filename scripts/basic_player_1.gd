extends "res://scripts/player/basic_player.gd"


func _ready()->void :
	super._ready()
	show_tutorial()

func _process(delta: float) -> void:
	super._process(delta)
	if  Input.is_action_just_pressed("attack")and accept_input  :
		if $Sword.visible:
			$Sword.swing()

func show_tutorial()->void:

	$Label.show()
	
	for tutorial in Texts.tutorial_texts:
		$Label.modulate.a = 1
		$Label.text = tutorial
		await get_tree().create_timer(1).timeout
		var tween:Tween = get_tree().create_tween()
		tween.tween_property($Label,"modulate:a",0,3)
		await tween.finished
		
		
		tween.stop()
		
		await get_tree().create_timer(1).timeout
		
		
	$Label.hide()
