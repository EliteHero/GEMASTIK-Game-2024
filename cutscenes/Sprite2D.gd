extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect to the size_changed signal of the viewport
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))
	# Initial position update
	_update_position()

# Function to update the position of the sprite to the center of the screen
func _update_position():
	var viewport_size = get_viewport().get_visible_rect().size
	position = viewport_size / 2

# Signal callback to update position when the viewport size changes
func _on_viewport_size_changed():
	_update_position()
