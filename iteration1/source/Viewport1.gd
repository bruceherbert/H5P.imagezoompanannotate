extends Viewport

onready var viewport = get_node("Viewport1")

func _ready():
	set_process_input(true)

func _unhandled_input(event):
	viewport.input(event)
