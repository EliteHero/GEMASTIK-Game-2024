extends Node2D

func all_objects_interacted():
	GlobalMusic.stop_hallway()
	get_tree().change_scene_to_file("res://cutscenes/cutscene_chapter_2_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
