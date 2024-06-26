extends StaticBody2D

var has_interacted: bool
@onready var color_rect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	has_interacted = GlobalEventListener.get_corpse_has_interacted()

func _on_hurtbox_area_entered(area):
	get_tree().call_group("player_overworld", "is_talking_true")
	get_tree().call_group("player_overworld", "hitbox_disabled")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	if has_interacted == false:
		Dialogic.start("corpse")
	elif has_interacted == true:
		Dialogic.start("has_interacted")

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().call_group("player_overworld", "is_talking_false")
	has_interacted = true
	GlobalEventListener.corpse_interacted()

func set_censor(censor):
	if censor == true:
		color_rect.visible = true
	elif censor == false:
		color_rect.visible = false
