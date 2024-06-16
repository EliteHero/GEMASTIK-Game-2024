extends CanvasLayer

func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene2")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_3.tscn")
