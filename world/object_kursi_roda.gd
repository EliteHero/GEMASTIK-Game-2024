extends StaticBody2D

var status: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	status = GlobalEventListener.has_interacted_kursi_roda

	
func _on_hurtbox_area_entered(area):
	get_tree().call_group("player_overworld", "is_talking_true")
	get_tree().call_group("player_overworld", "hitbox_disabled")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	if status == false:
		Dialogic.start("kursiroda")
	elif status == true:
		Dialogic.start("has_interacted")

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().call_group("player_overworld", "is_talking_false")
	status = true
	GlobalEventListener.kursi_roda_interacted()
