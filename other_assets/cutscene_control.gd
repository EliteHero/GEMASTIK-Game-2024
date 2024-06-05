extends Node2D

@onready var cutscene1 = $cutscene1
@onready var cutscene2 = $cutscene2

# Called when the node enters the scene tree for the first time.
func _ready():
	cutscene1.run()
	await cutscene1.on_cutscene_ends
	cutscene2.run()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
