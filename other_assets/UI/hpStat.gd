extends Control

@onready var hpSprite = $Panel/Sprite2D

var maxHp = 8
var hp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
func take_damage():
	hp -= 1
