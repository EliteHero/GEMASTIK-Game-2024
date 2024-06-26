extends CanvasLayer

@onready var item_name = $VBoxContainer/Panel_name/item_name
@onready var item_desc = $VBoxContainer/Panel_description/item_desc
@onready var btn_sfx = $btn_sfx

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
	btn_sfx.play()
	GlobalEventListener.unpause_game()

func _on_quit_btn_pressed():
	btn_sfx.play()
	get_tree().quit()

func _on_time_panel_btn_pressed():
	btn_sfx.play()
	item_name.text = "Panel Waktu"
	item_desc.text = "Sebuah panel waktu yang bekerja sebagai timer untuk 'injeksi'. Panel ini berada di samping setiap kapsul. Panel waktu kapsulku berhenti di 30 menit sedangkan panel waktu yang lain masih berjalan di menit 25"

func _on_robot_rusak_btn_pressed():
	btn_sfx.play()
	item_name.text = "Robot Rusak"
	item_desc.text = "Sebuah robot yang sudah hancur. Ia teletak di bawah mayat Pak Surya"


func _on_data_jumlah_btn_pressed():
	btn_sfx.play()
	item_name.text = "Data Jumlah"
	item_desc.text = "Panel kontrol yang terletak di atas dinding di samping mayat Pak Surya menunjukkan bahwa terdapat 9996/10000 manusia yang sedang berada di dalam kapsul"
