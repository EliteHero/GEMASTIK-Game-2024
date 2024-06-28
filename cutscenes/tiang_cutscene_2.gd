extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("tiang_cutscene2")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	GlobalEventListener.tiang_interacted()
	get_tree().change_scene_to_file("res://world/main_2_2.tscn")
