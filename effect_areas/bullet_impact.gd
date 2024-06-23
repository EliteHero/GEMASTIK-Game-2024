extends Node2D

@onready var animatedSprite2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite2d.frame = 0
	animatedSprite2d.play("default")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
