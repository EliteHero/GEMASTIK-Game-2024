extends Node

var is_transitioning: bool
var pause_menu

#battle variables
var last_battle_scene
var after_battle_scene
var current_hp

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
		if not is_transitioning:
			if get_tree().paused:
				unpause_game()
			else: 
				pause_game()

func pause_game():
	is_transitioning = true
	get_tree().paused = true
	TransitionPause.transition()
	await TransitionPause.on_transition_finished
	
	if pause_menu == null:
		var pause_menu_scene = preload("res://other_assets/UI/pause_screen.tscn")
		pause_menu = pause_menu_scene.instantiate()
		get_tree().root.add_child(pause_menu)
	is_transitioning = false

func unpause_game():
	is_transitioning = true
	if pause_menu:
		pause_menu.queue_free()
		pause_menu = null
	
	TransitionPause.transition_back()
	await TransitionPause.on_transition_finished
	get_tree().paused = false
	is_transitioning = false

func set_player_instance(player):
	player_instance = player
	
func get_player_position():
	if player_instance:
		return player_instance.global_position
	return null

func time_panel_interacted():
	has_interacted_time_panel = true
	btn_time_panel_disabled = false
	check_interaction_status()

func get_time_panel_has_interacted():
	return has_interacted_time_panel

func corpse_interacted():
	has_interacted_corpse = true
	btn_robot_rusak_disabled = false
	btn_data_jumlah_disabled = false
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

func debat_win():
	TransitionInterupsi.transition()
	await TransitionInterupsi.on_transition_finished
	GlobalMusic.stop_battle()
	TransitionBlack.transition()
	await TransitionBlack.on_transition_finished
	get_tree().change_scene_to_file(after_battle_scene)
