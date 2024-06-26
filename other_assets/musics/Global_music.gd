extends AudioStreamPlayer2D

@onready var exp_music = $"."
@onready var battle_music = $battle_music
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_exploration():
	if not exp_music.playing == true:
		exp_music.volume_db = 0
		exp_music.play()
		
func play_battle():
	if not battle_music.playing == true:
		battle_music.volume_db = 0
		battle_music.play()

func stop_exploration():
	if exp_music and exp_music.playing:
		animation.play("exp_music_off")
		await get_tree().create_timer(1).timeout
		exp_music.stop()
	
func stop_battle():
	if battle_music and battle_music.playing:
		animation.play("battle_music_off")
		await get_tree().create_timer(1).timeout
		battle_music.stop()
