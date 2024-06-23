extends Area2D

@onready var animation = $AnimationPlayer
var travelledDistance = 0
const SPEED = 1500
const ULTRA_SPEED = 5000
const RANGE = 1700

enum {
	attack_enemy,
	attack_player
}
var state = attack_enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("shot")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		attack_enemy:
			attack_enemy_state(delta)
		attack_player:
			attack_player_state(delta)

func create_impact():
	var impact = preload("res://effect_areas/bullet_impact.tscn")
	var effect = impact.instantiate()
	var world = get_tree().current_scene
	world.add_child(effect)
	effect.global_position = global_position

func attack_enemy_state(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	
	position += direction * SPEED * delta
	
	travelledDistance += SPEED * delta
	if travelledDistance > RANGE:
		queue_free()
		
func attack_player_state(delta):
	var player_pos = GlobalEventListener.get_player_position()
	
	var direction = (player_pos - position).normalized()
	rotation = direction.angle()
	
	position += direction * ULTRA_SPEED * delta
	
	travelledDistance += SPEED * delta
	if travelledDistance > RANGE:
		queue_free()

func change_state():
	if state == attack_enemy:
		state = attack_player
	else:
		state = attack_enemy

func player_shot():
	create_impact()
	queue_free()
