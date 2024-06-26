extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("player_overworld", "change_state", "CUTSCENE")
	change_player_anim("RIGHT")
	get_tree().call_group("Nova", "look_left")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene9")

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
	GlobalEventListener.current_hp = 8
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionDebat.transition()
	await TransitionDebat.on_transition_finished
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://adu_argumen/adu_argumen_1.tscn")
