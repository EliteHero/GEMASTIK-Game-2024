extends CharacterBody2D

signal text_die

const SPEED = 0.4

@onready var parent = get_parent()
var player_position
var mark
var player
var weakness: String
var immune: bool
var current_weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	parent.player_attack_signal.connect(_on_player_attack_signal)
	player = get_parent().get_node("amara_arena")
	player_position = player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (player_position - position)/ SPEED * delta
	move_and_slide()
	
	if position.distance_to(player_position) < 1:
		text_die.emit()
		queue_free()

func _on_player_attack_signal(weapon_data):
	current_weapon = weapon_data

func _on_hurtbox_area_entered(area):
	if immune == false and weakness == current_weapon:
		get_tree().call_group("Bullet", "create_impact")
		get_tree().call_group("Bullet", "queue_free")
		GlobalEventListener.debat_win()
	else:
		get_tree().call_group("Bullet", "set_collision_layer", 1 << 2)
		get_tree().call_group("Bullet", "change_state")
