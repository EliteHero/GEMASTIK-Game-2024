extends CanvasLayer

@onready var item_name = $VBoxContainer/Panel_name/item_name
@onready var item_desc = $VBoxContainer/Panel_description/item_desc

#buttons
@onready var time_panel_btn = $VBoxContainer/GridContainer/time_panel_btn
@onready var robot_rusak_btn =$VBoxContainer/GridContainer/robot_rusak_btn
@onready var data_jumlah_btn = $VBoxContainer/GridContainer/data_jumlah_btn

#buttons disabled states
@onready var btn_time_panel_disabled = GlobalEventListener.get_btn_time_panel()
@onready var btn_robot_rusak_disabled = GlobalEventListener.get_btn_robot_rusak()
@onready var btn_data_jumlah_disabled = GlobalEventListener.get_btn_data_jumlah()

# Called when the node enters the scene tree for the first time.
func _ready():
	check_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_button():
	time_panel_btn.disabled = btn_time_panel_disabled
	robot_rusak_btn.disabled = btn_robot_rusak_disabled
	data_jumlah_btn.disabled = btn_data_jumlah_disabled

func _on_resume_btn_pressed():
	GlobalEventListener.unpause_game()

func _on_quit_btn_pressed():
	get_tree().quit()
