extends CanvasLayer

signal on_cutscene_ends

@onready var text_rect = $TextureRect

# Called when the node enters the scene tree for the first time.
func run():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene1")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Transitions.transition()
	await Transitions.on_transition_finished
	text_rect.visible = false
	on_cutscene_ends.emit()
