extends Node2D

var arguments = [
	"Aku datang ke sini sekitar 3 menit yang lalu",
	"Lalu aku bertabrakan denganmu",
	"Kamu harusnya masih di kapsul sekarang",
	"Namun kamu bangun",
	"Dan hanya dirimu yang bangun",
	"Jadi, hanya kamulah yang bisa membunuhnya!"
]

var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("HpStat", "set_hp", 8)
	var enemy = preload("res://characters/enemy.tscn")
	var text = enemy.instantiate()
	var textSpawn = $MobPath/MobSpawn
	textSpawn.progress_ratio = randf()
	text.position = textSpawn.position
	await get_tree().create_timer(2).timeout

	add_child(text)
	text.get_node("Label").text = "Buktinya sangat sederhana"


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
