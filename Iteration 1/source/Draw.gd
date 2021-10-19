extends Node2D

var originX = 0
var originY = 0
var typeToMake = "null"
onready var rectangle = $Rectangle
onready var textInput = $TextInput

func init(type):
	typeToMake = type

func _ready():
	#init()
	originX = get_global_mouse_position().x
	originY = get_global_mouse_position().y
	
	if typeToMake == "Rectangle":
		rectangle.visible = true
		textInput.visible = false

	if typeToMake == "Text":
		rectangle.visible = false
		textInput.visible = true
	
func _on_delete_pressed():
	print("delete")
	self.queue_free()
