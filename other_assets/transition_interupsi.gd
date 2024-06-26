extends CanvasLayer

signal on_transition_finished

@onready var sfx = $sfx
@onready var sprite_frame = $transition_interupsi_sprite
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
	self.visible = true
	animation_player.play("transition")
	
func _on_animation_finished(anim_name):
	await get_tree().create_timer(1).timeout
	on_transition_finished.emit()
	await get_tree().create_timer(0.5).timeout
	self.visible = false
