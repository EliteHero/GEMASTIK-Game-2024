extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	change_player_anim("UP")
	get_tree().call_group("player_overworld", "change_state", "CUTSCENE")
	Dialogic.signal_event.connect(_on_dialogic_text_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene6")

func _on_dialogic_text_signal(argument: String):
	if argument == "turn_left_right":
		change_player_anim("LEFT")
		await get_tree().create_timer(1).timeout 
		change_player_anim("RIGHT")
	if argument == "turn_down":
		change_player_anim("DOWN")

func change_player_anim(state):
	match state:
		"RIGHT":
			get_tree().call_group("player_overworld", "cutscene_move", "RIGHT")
		"LEFT":
			get_tree().call_group("player_overworld", "cutscene_move", "LEFT")
		"UP":
			get_tree().call_group("player_overworld", "cutscene_move", "UP")
		"DOWN":
			get_tree().call_group("player_overworld", "cutscene_move", "DOWN")

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/interlude.tscn")
