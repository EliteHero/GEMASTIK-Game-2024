extends CanvasLayer

@onready var animasi = $AnimationPlayer
@onready var color_rect = $ColorRect

func _ready():
	await get_tree().create_timer(1).timeout
	animasi.play("bangun")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene5")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	color_rect.visible = true
	await get_tree().create_timer(2).timeout 
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_6.tscn")
