extends Node2D

@onready var colorRect = $CanvasLayer/ColorRect
@onready var music = $AudioStreamPlayer2D
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("player_overworld", "change_state", "CUTSCENE")
	change_player_anim("RIGHT")
	Dialogic.signal_event.connect(_on_dialogic_text_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene8")

func _on_dialogic_text_signal(argument: String):
	if argument == "color_off":
		TransitionBlack.transition()
		await TransitionBlack.on_transition_finished
		colorRect.visible = false
	if argument == "nova_move":
		await get_tree().create_timer(0.5).timeout
		get_tree().call_group("Nova", "move_up", 0.7)
	if argument == "amara_move":
		change_player_anim("UP")
	if argument == "nova_move_down":
		get_tree().call_group("Nova", "look_down")
	if argument == "play music":
		music.play()

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
	animation.play("music_stop")
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://world/main_1.tscn")
