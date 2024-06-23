extends StaticBody2D

var input_vector = Vector2.ZERO
var status: bool
@onready var animation_tree = $AnimationTree
@onready var animationState = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true
	status = GlobalEventListener.get_nova_has_interacted()

func _process(float) -> void:
	animationState.travel("Move")
	animation_tree.set("parameters/Move/blend_position", input_vector)

func update_facing_direction(hitbox_position: Vector2):
	var direction_vector = hitbox_position - global_position

	if abs(direction_vector.x) > abs(direction_vector.y):
		if direction_vector.x > 0:
			input_vector = Vector2(1, 0)  # Right
		else:
			input_vector = Vector2(-1, 0)  # Left
	else:
		if direction_vector.y > 0:
			input_vector = Vector2(0, 1)  # Down
		else:
			input_vector = Vector2(0, -1)  # Up

func _on_hurtbox_area_entered(area):
	var player = area.get_parent()
	update_facing_direction(player.global_position)
	get_tree().call_group("player_overworld", "is_talking_true")
	get_tree().call_group("player_overworld", "hitbox_disabled")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	if status == false:
		Dialogic.start("interactable_nova1")
	elif status == true:
		Dialogic.start("interactable_nova2")
		
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	status = true
	GlobalEventListener.time_panel_interacted()
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().call_group("player_overworld", "is_talking_false")
