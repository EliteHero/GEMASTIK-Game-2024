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

#Chapter 2 items
var has_interacted_kursi_roda: bool = false
var has_interacted_tiang: bool = false
var has_interacted_serpihan: bool = false
var has_interacted_log: bool = false
var has_interacted_inovasi: bool = false
var has_interacted_stepladder: bool = false

#pause button states
var btn_time_panel_disabled = true
var btn_robot_rusak_disabled = true
var btn_data_jumlah_disabled = true
var btn_kursi_roda_disabled = true
var btn_tiang_disabled = true
var btn_serpihan_disabled = true
var btn_log_disabled = true
var btn_jejak_roda_disabled = true
var btn_inovasi_disabled = true

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

#Chapter 2 items
func check_interaction_status2():
	if has_interacted_kursi_roda and has_interacted_tiang and has_interacted_serpihan and has_interacted_log and has_interacted_inovasi:
		get_tree().call_group("Main2", "all_objects_interacted")

func kursi_roda_interacted():
	has_interacted_kursi_roda = true
	btn_kursi_roda_disabled = false
	check_interaction_status2()
	
func tiang_interacted():
	has_interacted_tiang = true
	btn_tiang_disabled = false
	check_interaction_status2()
	
func serpihan_interacted():
	has_interacted_serpihan = true
	btn_serpihan_disabled = false
	check_interaction_status2()
	
func stepladder_interacted():
	has_interacted_stepladder = true
	
func log_interacted():
	has_interacted_log = true
	btn_log_disabled = false
	btn_jejak_roda_disabled = false
	check_interaction_status2()
	
func inovasi_interacted():
	has_interacted_inovasi = true
	btn_inovasi_disabled = false
	check_interaction_status2()
