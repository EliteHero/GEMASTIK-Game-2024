extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		if GlobalEventListener.last_battle_scene != "":
			TransitionBlack.transition()
			await TransitionBlack.on_transition_finished
			get_tree().change_scene_to_file(GlobalEventListener.last_battle_scene)
