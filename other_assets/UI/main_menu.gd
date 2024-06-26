extends CanvasLayer

@onready var btn_sfx = $btn_sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_btn_pressed():
	btn_sfx.play()
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/cutscene_1.tscn")


func _on_credit_btn_pressed():
	btn_sfx.play()
	var credit_screen = preload("res://other_assets/UI/credit_screen.tscn")
	var credit_screen_inst = credit_screen.instantiate()
	get_tree().root.add_child(credit_screen_inst)


func _on_keluar_btn_pressed():
	btn_sfx.play()
	get_tree().quit()
