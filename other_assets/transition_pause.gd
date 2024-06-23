extends CanvasLayer

signal on_transition_finished

@onready var pause_sprite = $pause_sprites
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_sprite.frame = 0
	pause_sprite.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	pause_sprite.visible = false
	on_transition_finished.emit()
	
func transition():
	animation_player.play("transition")
	pause_sprite.visible = true

func transition_back():
	animation_player.play("transition_back")
	pause_sprite.visible = true
