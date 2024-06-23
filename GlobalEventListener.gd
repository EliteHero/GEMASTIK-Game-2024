extends Node

var has_interacted_time_panel: bool = false
var has_interacted_corpse: bool = false
var has_interacted_nova: bool = false
var player_instance = null


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
