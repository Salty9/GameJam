extends Control

signal key_pressed
var tween:Tween
var continued:bool = true
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and not continued:
		key_pressed.emit()
		continued = true
		hide()
		if tween != null:
			tween.stop()
			tween.kill()

	

func show_transition()->void:
	continued = false
	
	await get_tree().create_tween().tween_property(self,"modulate:a",1,1).finished
	
	
	tween = get_tree().create_tween()
	
	
	tween.tween_property($LowerLabel,"modulate:a",1,0.5)
	tween.tween_property($LowerLabel,"modulate:a",0,0.5)
	tween.set_loops()
