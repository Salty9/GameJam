extends Node


var tutorial_texts
var story_texts

func _ready()->void:
	tutorial_texts = JSON.parse_string( FileAccess.get_file_as_string("res://data/tutorial.json"))
	
	story_texts = JSON.parse_string(FileAccess.get_file_as_string("res://data/story_separated.json"))
