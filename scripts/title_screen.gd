extends Control


signal key_pressed


var continued:bool=true
var tween :Tween
func _process(delta: float) -> void:
	if not continued and Input.is_action_just_pressed("ui_accept"):
		continued = false
		key_pressed.emit()
		
		if tween != null:
			tween.stop()
			tween.kill()
			hide()


func blink_label()->void:
	continued = false
	tween = get_tree().create_tween()
	tween.tween_property($Label,"modulate:a",0,0.5)
	tween.tween_property($Label,"modulate:a",1,0.5)
	tween.set_loops()
