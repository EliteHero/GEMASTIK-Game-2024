extends Node2D

func _ready():
	GlobalMusic.play_hallway()
	get_tree().call_group("player_overworld", "change_state", "CUTSCENE")
	change_player_anim("DOWN")
	get_tree().call_group("Nova", "look_down")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.signal_event.connect(_on_dialogic_text_signal)
	Dialogic.start("cutscen_chapter2_1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	get_tree().change_scene_to_file("res://world/main_2_1.tscn")

func _on_dialogic_text_signal(argument: String):
	if argument == "face to face":
		get_tree().call_group("Nova", "look_right")
		change_player_anim("LEFT")
