extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("player_overworld", "eternal_hitbox_disabled", true)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_7.tscn")

func _on_area_2d_body_entered(body):
	get_tree().call_group("player_overworld", "cutscene_move", "DOWN")
	get_tree().call_group("player_overworld", "change_state", "CUTSCENE")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("interlude")
