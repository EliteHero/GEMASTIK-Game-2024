extends Node2D

var arguments = [
	"This is the second argument",
	"This is the third argument"
]

var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = preload("res://characters/enemy.tscn")
	var text = enemy.instantiate()
	var textSpawn = $MobPath/MobSpawn
	textSpawn.progress_ratio = randf()
	text.position = textSpawn.position
	await get_tree().create_timer(2).timeout

	add_child(text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_argument():
	var enemy = preload("res://characters/enemy.tscn")
	var text = enemy.instantiate()
	var textSpawn = $MobPath/MobSpawn
	textSpawn.progress_ratio = randf()
	text.position = textSpawn.position
	
	add_child(text)
	text.get_node("Label").text = arguments[counter]
	counter += 1
