extends CanvasLayer

func _ready():
	$Timer.start(5)

func _on_timer_timeout():
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_4.tscn")
