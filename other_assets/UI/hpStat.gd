extends Control

@onready var hpSprite = $Panel/hp_sprite
var hp

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = GlobalEventListener.current_hp
	update_hp_sprite()

func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_hp_sprite():
	if hpSprite == null:
		return
	match hp:
		8:
			hpSprite.frame = 0
		7:
			hpSprite.frame = 1
		6:
			hpSprite.frame = 2
		5:
			hpSprite.frame = 3
		4:
			hpSprite.frame = 4
		3:
			hpSprite.frame = 5
		2:
			hpSprite.frame = 6
		1:
			hpSprite.frame = 7
		0:
			hpSprite.frame = 8

func set_hp(setHp: int):
	hp = setHp
	update_hp_sprite()
	
func take_damage():
	hp -= 1
	GlobalEventListener.current_hp = hp
	update_hp_sprite()
	if hp == 0:
		game_over()

func game_over():
	GlobalEventListener.current_hp = 8
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file("res://cutscenes/game_over_screen.tscn")
