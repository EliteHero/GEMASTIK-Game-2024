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
	{"label" : "empty", "immune" : true, "weakness": "none", "color" : Color.WHITE}
]

var items = [
	{"name" : "Panel Waktu", "sprite" : preload("res://other_assets/UI/Items_sprite/panel_waktu.png")},
	{"name" : "Robot Rusak", "sprite" : preload("res://other_assets/UI/Items_sprite/broken_robot.png")},
	{"name" : "Data Jumlah Manusia", "sprite" : preload("res://other_assets/UI/Items_sprite/data_jumlah.png")}
]

@onready var inventory = $CanvasLayer/inventory_ui
@onready var item_slot = inventory.send_children()
@onready var player = $amara_arena
@onready var scroll_cooldown_timer = $scroll_cooldown_timer
var picked_color = Color.WHITE
var normal_color = Color.html("#007B7B")
var current_item = 1
var current_weapon 
var switch_item: bool
var can_scroll = true

const SCROLL_COOLDOWN = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalMusic.play_battle()
	GlobalEventListener.after_battle_scene = "res://cutscenes/cutscene_10.tscn"
	GlobalEventListener.last_battle_scene = "res://adu_argumen/adu_argumen_1.tscn"
	new_argument(arguments)
	switch_item = true
	
	var n = 1
	for item in items:
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
			item_slot[5].modulate = normal_color
			item_slot[3].modulate = normal_color
			current_weapon = items[0]["name"]
		2:
			inventory.change_text(items[1]["name"])
			item_slot[3].modulate = picked_color
			item_slot[1].modulate = normal_color
			item_slot[5].modulate = normal_color
			current_weapon = items[1]["name"]
		3:
			inventory.change_text(items[2]["name"])
			item_slot[5].modulate = picked_color
			item_slot[1].modulate = normal_color
			item_slot[3].modulate = normal_color
			current_weapon = items[2]["name"]
	
	if Input.is_action_just_pressed("nextItem") and switch_item == true:
		next_item()
	elif Input.is_action_just_pressed("prev_item") and switch_item == true:
		prev_item()

func new_argument(arguments):
	for argument in arguments:
		if argument["label"] == "empty":
			TransitionBlack.transition()
			await TransitionBlack.on_transition_finished
			get_tree().change_scene_to_file("res://adu_argumen/adu_argumen_1_rest.tscn")
			return
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

func _input(event):
	if switch_item == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and can_scroll:
				next_item()
				can_scroll = false
				scroll_cooldown_timer.start(SCROLL_COOLDOWN)
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP and can_scroll:
				prev_item()
				can_scroll = false
				scroll_cooldown_timer.start(SCROLL_COOLDOWN)
		if event is InputEventKey and event.pressed:
			match event.keycode:
				KEY_1:
					current_item = 1
				KEY_2:
					current_item = 2
				KEY_3:
					current_item = 3

func next_item():
	if current_item == 3:
		current_item = 1
	else:
		current_item += 1

func prev_item():
	if current_item == 1:
		current_item = 3
	else:
		current_item -= 1

func set_switch_item(state):
	switch_item = state

func player_attack():
	player_attack_signal.emit(current_weapon)


func _on_scroll_cooldown_timer_timeout():
	can_scroll = true
