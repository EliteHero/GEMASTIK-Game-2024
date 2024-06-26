extends CanvasLayer

signal on_transition_finished

@onready var sfx = $sfx
@onready var sprite_frame = $transition_debat_sprite
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_frame.frame = 0
	self.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition():
	sfx.play()
	GlobalMusic.stop_exploration()
	self.visible = true
	animation_player.play("transition")
	get_tree().call_group("player_overworld", "shake_camera")
	
func _on_animation_finished(anim_name):
	self.visible = false
	on_transition_finished.emit()
