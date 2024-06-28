extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trigger_body_entered(body):
	if body.name == "amara_overworld":
		get_tree().call_group("player_overworld", "change_state", "CUTSCENE")
		get_tree().call_group("player_overworld", "cutscene_move", "RIGHT")
		TransitionBlack.transition()
		await TransitionBlack.on_transition_finished
		get_tree().change_scene_to_file("res://cutscenes/tiang_cutscene.tscn")
