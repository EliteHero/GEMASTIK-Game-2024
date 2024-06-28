extends CharacterBody2D

enum {
	MOVE,
	IDLE
}

# Speed of the NPC
var speed = 100
# Timer to control the duration of movement
var move_timer: Timer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
var state = MOVE

func _ready():
	animationTree.active = true
	move_timer = Timer.new()
	move_timer.one_shot = true
	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
	add_child(move_timer)

func _process(delta):
	if state == MOVE and velocity != Vector2.ZERO:
		move_and_slide()
	
	animationTree.set("parameters/Move/blend_position", velocity)
	animationState.travel("Move")

# Function to move right for a given duration
func move_right(duration):
	velocity = Vector2(speed, 0)
	start_move_timer(duration)

# Function to move left for a given duration
func move_left(duration):
	velocity = Vector2(-speed, 0)
	start_move_timer(duration)

# Function to move down for a given duration
func move_down(duration):
	velocity = Vector2(0, speed)
	start_move_timer(duration)

# Function to move up for a given duration
func move_up(duration):
	velocity = Vector2(0, -speed)
	start_move_timer(duration)

# Function to start the move timer
func start_move_timer(duration):
	move_timer.start(duration)

# Function called when the move timer times out
func _on_move_timer_timeout():
	velocity = Vector2.ZERO  # Stop movement

func look_down():
	state = IDLE
	velocity = Vector2(0, 1)

func look_right():
	state = IDLE
	velocity = Vector2(1,0)

func look_left():
	velocity = Vector2(-1, 0)
	await get_tree().create_timer(0.0001).timeout
	velocity = Vector2.ZERO
