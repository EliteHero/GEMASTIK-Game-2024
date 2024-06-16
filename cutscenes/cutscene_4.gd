extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var timer = $Timer

func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene4")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionWhite.transition()
	await TransitionWhite.on_transition_finished
	color_rect.visible = true
	timer.start(3)

func _on_timer_timeout():
	TransitionWhite.transition()
	await TransitionWhite.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_5.tscn")
