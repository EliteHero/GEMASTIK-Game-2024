extends Control

@onready var label = $Label

func get_all_descendants(node):
	var descendants = []
	for child in node.get_children():
		descendants.append(child)
		descendants += get_all_descendants(child)
	return descendants

func _ready():
	var all_descendants = get_all_descendants($PanelContainer/HBoxContainer)

func send_children():
	var all_descendants = get_all_descendants($PanelContainer/HBoxContainer)
	return all_descendants

func change_text(text):
	label.text = text
