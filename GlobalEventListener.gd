extends Node

var has_interacted_time_panel: bool = false
var has_interacted_corpse: bool = false

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
	if has_interacted_time_panel and has_interacted_corpse:
		print("Both objects have been interacted")
