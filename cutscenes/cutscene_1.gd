extends CanvasLayer

@onready var music = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.signal_event.connect(_on_dialogic_text_signal)
	Dialogic.start("cutscene1")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionWhite.transition()
	await TransitionWhite.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_2.tscn")

func _on_dialogic_text_signal(argument: String):
	if argument == "stop music":
		music.stop()
