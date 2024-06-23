extends Node2D

signal player_attack_signal(weapon_data)

var arguments = [
	{"label" : "Buktinya sangat sederhana", "immune" : true, "weakness": "none", "color" : Color.WHITE},
	{"label" : "Aku datang ke sini sekitar 3 menit yang lalu", "immune" : true, "weakness": "none", "color" : Color.YELLOW},
	{"label" : "Lalu aku bertabrakan denganmu", "immune" : true, "weakness": "none", "color" : Color.WHITE},
	{"label" : "Kamu harusnya masih di kapsul sekarang", "immune" : true, "weakness": "none", "color" : Color.WHITE},
	{"label" : "Namun kamu bangun", "immune" : true, "weakness": "none", "color" : Color.WHITE},
	{"label" : "Dan hanya dirimu yang bangun", "immune" : false, "weakness": "Data Jumlah Manusia", "color" : Color.YELLOW},
	{"label" : "Jadi, hanya kamulah yang bisa membunuhnya!", "immune" : true, "weakness": "none", "color" : Color.WHITE},
]

var items = [
	{"name" : "Panel Waktu", "sprite" : preload("res://other_assets/UI/Items_sprite/panel_waktu.png")},
	{"name" : "Data Jumlah Manusia", "sprite" : preload("res://other_assets/UI/Items_sprite/panel_waktu.png")}
]

@onready var inventory = $CanvasLayer/inventory_ui
@onready var item_slot = inventory.send_children()
@onready var player = $amara_arena
var picked_color = Color.WHITE
var normal_color = Color.html("#007B7B")
var current_item = 1
var current_weapon 
var switch_item: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	new_argument()
	get_tree().call_group("HpStat", "set_hp", 8)
	switch_item = true
	
	var n = 1
	for item in items:
		while n < 5:
			var texture_rect = item_slot[n]
			var texture = item["sprite"]
			texture_rect.texture = texture
			n += 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_item:
		1:
			inventory.change_text(items[0]["name"])
			item_slot[1].modulate = picked_color
			item_slot[3].modulate = normal_color
			current_weapon = "Panel Waktu"
		2:
			inventory.change_text(items[1]["name"])
			item_slot[3].modulate = picked_color
			item_slot[1].modulate = normal_color
			current_weapon = "Data Jumlah Manusia"
	
	if Input.is_action_just_pressed("nextItem") and switch_item == true:
		next_item()
	elif Input.is_action_just_pressed("prev_item") and switch_item == true:
		prev_item()

func new_argument():
	for argument in arguments:
		var enemy = preload("res://characters/enemy.tscn")
		var text = enemy.instantiate()
		var textSpawn = $MobPath/MobSpawn
		textSpawn.progress_ratio = randf()
		text.position = textSpawn.position
		
		add_child(text)
		text.get_node("Label").text = argument["label"]
		text.get_node("Label").add_theme_color_override("font_color", argument["color"])
		text.immune = argument["immune"]
		text.weakness = argument["weakness"]
		await text.text_die
		

func next_item():
	if current_item == 2:
		current_item = 1
	else:
		current_item += 1

func prev_item():
	if current_item == 1:
		current_item = 2
	else:
		current_item -= 1

func set_switch_item(state):
	switch_item = state

func player_attack():
	player_attack_signal.emit(current_weapon)
