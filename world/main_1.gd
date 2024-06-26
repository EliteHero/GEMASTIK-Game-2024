extends Node2D

func all_objects_interacted():
	get_tree().change_scene_to_file("res://cutscenes/cutscene_9.tscn")

func _ready():
	GlobalMusic.play_exploration()

func _on_boundary_body_entered(body):
	if body.name == "amara_overworld":
		get_tree().call_group("player_overworld", "cutscene_move", "DOWN")
		get_tree().call_group("player_overworld", "change_state", "CUTSCENE")
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		Dialogic.start("boundary1")

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().call_group("player_overworld", "set_player_position", 40, 850)
	get_tree().call_group("player_overworld", "change_state", "MOVE")
