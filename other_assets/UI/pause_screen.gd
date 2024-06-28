extends CanvasLayer

@onready var item_name = $VBoxContainer/Panel_name/item_name
@onready var item_desc = $VBoxContainer/Panel_description/item_desc
@onready var btn_sfx = $btn_sfx

#buttons
@onready var time_panel_btn = $VBoxContainer/GridContainer/time_panel_btn
@onready var robot_rusak_btn =$VBoxContainer/GridContainer/robot_rusak_btn
@onready var data_jumlah_btn = $VBoxContainer/GridContainer/data_jumlah_btn
@onready var kursi_roda_btn = $VBoxContainer/GridContainer/kursi_roda_btn
@onready var log_btn = $VBoxContainer/GridContainer/log_btn
@onready var jejak_roda_btn = $VBoxContainer/GridContainer/jejak_roda_btn
@onready var inovasi_btn = $VBoxContainer/GridContainer/inovasi_btn
@onready var tiang_btn = $VBoxContainer/GridContainer/tiang_btn
@onready var serpihan_btn = $VBoxContainer/GridContainer/serpihan_btn

#buttons disabled states
@onready var btn_time_panel_disabled = GlobalEventListener.get_btn_time_panel()
@onready var btn_robot_rusak_disabled = GlobalEventListener.get_btn_robot_rusak()
@onready var btn_data_jumlah_disabled = GlobalEventListener.get_btn_data_jumlah()
@onready var btn_kursi_roda_disabled = GlobalEventListener.btn_kursi_roda_disabled
@onready var btn_log_disabled = GlobalEventListener.btn_log_disabled
@onready var btn_jejak_roda_disabled = GlobalEventListener.btn_jejak_roda_disabled
@onready var btn_inovasi_disabled = GlobalEventListener.btn_inovasi_disabled
@onready var btn_tiang_disabled = GlobalEventListener.btn_tiang_disabled
@onready var btn_serpihan_disabled = GlobalEventListener.btn_serpihan_disabled

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
	kursi_roda_btn.disabled = btn_kursi_roda_disabled
	log_btn.disabled = btn_log_disabled
	jejak_roda_btn.disabled = btn_jejak_roda_disabled
	inovasi_btn.disabled = btn_inovasi_disabled
	tiang_btn.disabled = btn_tiang_disabled
	serpihan_btn.disabled = btn_serpihan_disabled

func _on_resume_btn_pressed():
	btn_sfx.play()
	GlobalEventListener.unpause_game()

func _on_quit_btn_pressed():
	btn_sfx.play()
	get_tree().quit()

func _on_time_panel_btn_pressed():
	btn_sfx.play()
	item_name.text = "Panel Waktu"
	item_desc.text = "Sebuah panel waktu yang bekerja sebagai timer untuk 'injeksi'. Panel ini berada di samping setiap kapsul. Panel waktu kapsulku berhenti di 30 menit sedangkan panel waktu yang lain masih berjalan di menit 25."

func _on_robot_rusak_btn_pressed():
	btn_sfx.play()
	item_name.text = "Robot Rusak"
	item_desc.text = "Sebuah robot yang sudah hancur. Ia teletak di bawah mayat Pak Surya."


func _on_data_jumlah_btn_pressed():
	btn_sfx.play()
	item_name.text = "Data Jumlah Manusia"
	item_desc.text = "Panel kontrol yang terletak di atas dinding di samping mayat Pak Surya menunjukkan bahwa terdapat 9996/10000 manusia yang sedang berada di dalam kapsul."

func _on_kursi_roda_btn_pressed():
	btn_sfx.play()
	item_name.text = "Kursi Roda"
	item_desc.text = "Kursi roda yang terletak di koridor. Bagian belakangnya terlihat rusak dari hantaman. Kabelnya terbuat dari kabel yang sama dengan kabel kapsul."

func _on_log_btn_pressed():
	btn_sfx.play()
	item_name.text = "Log Pintu"
	item_desc.text = "14.00, sebuah robot perawat masuk ke dalam ruangan kapsul. 14.04 - 14.05, Pak Surya dan 'Objek tidak teridentifikasi' keluar masuk ruangan hingga pada 14.06 hanya objek itu yang keluar."

func _on_jejak_roda_btn_pressed():
	btn_sfx.play()
	item_name.text = "Jejak Roda"
	item_desc.text = "Sebuah jejak roda tepat di depan pintu. Jejak ini dihasilkan karena roda yang berbelok atau berputar dengan cepat."

func _on_inovasi_btn_pressed():
	btn_sfx.play()
	item_name.text = "Inovasi"
	item_desc.text = "Inovasi dari mahasiswa dan mahasiswi Politeknik Bhaskara. Ia menunjukkan inovasi untuk memitigasi dampak perubahan iklim."

func _on_tiang_btn_pressed():
	btn_sfx.play()
	item_name.text = "Tiang Listrik"
	item_desc.text = "Tiang listrik yang terletak di samping gedung yang tampaknya terbawa oleh angin puting beliung. Terdapat beberapa kabel yang sama dengan kabel di kapsul."

func _on_serpihan_btn_pressed():
	btn_sfx.play()
	item_name.text = "Serpihan Kaca"
	item_desc.text = "Serpihan kaca yang terletak di dalam gedung, menandakan ada sebuah objek yang menghantam kaca dari arah selatan ke utara."
