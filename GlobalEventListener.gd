extends Node

var pause_menu

var has_interacted_time_panel: bool = false
var has_interacted_corpse: bool = false
var has_interacted_nova: bool = false
var player_instance = null

#pause button states
var btn_time_panel_disabled = true
var btn_robot_rusak_disabled = true
var btn_data_jumlah_disabled = true

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if get_tree().paused:
			unpause_game()
		else: 
			pause_game()

func pause_game():
	get_tree().paused = true
	TransitionPause.transition()
	await TransitionPause.on_transition_finished
	
	var pause_menu_scene = preload("res://other_assets/UI/pause_screen.tscn")
	pause_menu = pause_menu_scene.instantiate()
	get_tree().root.add_child(pause_menu)

func unpause_game():
	pause_menu.queue_free()
	pause_menu = null
	TransitionPause.transition_back()
	await TransitionPause.on_transition_finished
	get_tree().paused = false

func set_player_instance(player):
	player_instance = player
	
func get_player_position():
	if player_instance:
		return player_instance.global_position
	return null

func time_panel_interacted():
	has_interacted_time_panel = true
	check_interaction_status()

func get_time_panel_has_interacted():
	return has_interacted_time_panel

func corpse_interacted():
	has_interacted_corpse = true
	check_interaction_status()
	
func get_corpse_has_interacted():
	return has_interacted_corpse
	
func check_interaction_status():
	if has_interacted_time_panel and has_interacted_corpse and has_interacted_nova:
		get_tree().call_group("Main1", "all_objects_interacted")

func nova_interacted():
	has_interacted_nova = true
	check_interaction_status()

func get_nova_has_interacted():
	return has_interacted_nova

#button functions
func get_btn_time_panel():
	return btn_time_panel_disabled
	
func get_btn_robot_rusak():
	return btn_robot_rusak_disabled
	
func get_btn_data_jumlah():
	return btn_data_jumlah_disabled
