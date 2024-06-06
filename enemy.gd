extends CharacterBody2D

const SPEED = 25

var player_position
var mark
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("amara_arena")
	player_position = player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (player_position - position)/SPEED
	move_and_slide()
	
	if position.distance_to(player_position) < 1:
		get_tree().call_group("AduArgumen", "new_argument")
		queue_free()
