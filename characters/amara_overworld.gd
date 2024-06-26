extends CharacterBody2D

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 1000

enum {
	MOVE,
	CUTSCENE
}

var direction = Vector2.ZERO
var state = MOVE
var is_talking = false
var eternal_hitbox_status = false

@onready var hitbox = $Marker2D/Hitbox/CollisionShape2D
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			if is_talking == false:
				move_state(delta)
				
				if Input.is_action_just_pressed("Interact") and !eternal_hitbox_status:
					hitbox.disabled = false
					await get_tree().create_timer(1).timeout
					hitbox.disabled = true
			elif is_talking == true:
				animationState.travel("Idle")
		CUTSCENE:
			cutscene_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()

func cutscene_state(delta):
	animationTree.set("parameters/Idle/blend_position", direction)
	animationState.travel("Idle")
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
func cutscene_move(move):
	if move == "DOWN":
		direction.x = 0
		direction.y = 1
	elif move == "UP":
		direction.x = 0
		direction.y = -1
	elif move == "RIGHT":
		direction.x = 1
		direction.y = 0
	elif move == "LEFT":
		direction.x = -1
		direction.y = 0

func change_state(new_state):
	if new_state == "CUTSCENE":
		state = CUTSCENE
	elif new_state == "MOVE":
		state = MOVE
		
func is_talking_true():
	is_talking = true
	
func is_talking_false():
	is_talking = false

func hitbox_disabled():
	hitbox.set_deferred("disabled", true)
	
func eternal_hitbox_disabled(status):
	eternal_hitbox_status = status

func set_player_position(x,y):
	global_position = Vector2(x,y)

func shake_camera():
	$Camera2D.shake_camera()
