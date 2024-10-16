extends AudioStreamPlayer2D
class_name AudioPlayer
func _ready()->void:
	finished.connect(queue_free)
