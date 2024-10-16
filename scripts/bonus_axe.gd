extends Area2D


func _ready() -> void:
	body_entered.connect(on_body_entered)
	
func on_body_entered(body)->void:
	if body is Character and body.is_in_group("player_group"):
		var axe = body.find_child("Axe")
		if axe != null:
			axe.max_count += 1
			axe.axe_count += 1
		
		queue_free()
