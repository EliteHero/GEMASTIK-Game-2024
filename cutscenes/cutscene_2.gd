extends CanvasLayer


func run():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("cutscene2")
	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
