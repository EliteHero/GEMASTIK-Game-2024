extends CharacterBody2D

const ACCELERATION = 1000
const MAX_SPEED = 150
const FRICTION = 1000

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var attacking = false

@onready var hurtAnim = $HurtAnimationPlayer
@onready var camera = $Camera2D
@onready var hurtbox = $PlayerHurtbox/CollisionShape2D
@onready var iframeTimer = $iframe_timer
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var bulletPivot = $BulletPivot

func _ready():
	GlobalEventListener.set_player_instance(self)
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	bulletPivot.rotation = direction.angle()
	
	if attacking == false:
		get_tree().call_group("AduArgumen", "set_switch_item", false)
		attacking = true
		var bulletScene = preload("res://effect_areas/bullet.tscn")
		var bullet = bulletScene.instantiate()
		bullet.global_position = bulletPivot.global_position
		bullet.rotation = bulletPivot.rotation
		bullet.global_position = global_position
		await get_tree().create_timer(0.3).timeout 
		get_tree().root.add_child(bullet)
		
		get_parent().player_attack()
	
func attack_finished():
	state = MOVE
	get_tree().call_group("AduArgumen", "set_switch_item", true)
	attacking = false

func iframe_on():
	iframeTimer.start(1)
	hurtbox.disabled = true
	
func _on_iframe_timer_timeout():
	hurtbox.disabled = false

func _on_player_hurtbox_area_entered(area):
	hurtAnim.play("hurt")
	camera.shake_camera()
	get_tree().call_group("HpStat", "take_damage")
	
	if area.is_in_group("Bullet"):
		get_tree().call_group("Bullet", "player_shot")

func get_player_position():
	return global_position
