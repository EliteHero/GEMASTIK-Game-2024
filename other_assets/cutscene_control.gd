extends Node2D

@onready var cutscene1 = $transitionWhite/cutscene1
@onready var cutscene2 = $transitionWhite/cutscene2
@onready var cutscene3 = $transitionWhite/cutscene3
@onready var cutscene4 = $transitionWhite/cutscene4

# Called when the node enters the scene tree for the first time.
func _ready():
	cutscene1.run()
	await cutscene1.on_cutscene_ends
	cutscene2.run()
	await cutscene2.on_cutscene_ends
	cutscene3.run()
	await cutscene3.on_cutscene_ends
	cutscene4.run()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
