extends Node2D

var image_draggable = false
const PAN_FACTOR = 10
onready var image = $Image

func _ready():
	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	print("area just clicked")
	if Input.is_action_just_pressed("click"):
		image_draggable = true

func _input(event):
	if event is InputEventMouseButton:
		print("clicking", event.button_index)
		if event.button_index == BUTTON_LEFT and not event.pressed:
			print("is this happening?")
			image_draggable = false

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("pan_right") - Input.get_action_strength("pan_left")
	input_vector.y = Input.get_action_strength("pan_down") - Input.get_action_strength("pan_up")
	input_vector = input_vector.normalized()
	
	var moveH = input_vector.x * PAN_FACTOR
	var moveV = input_vector.y * PAN_FACTOR	
	
	if image_draggable:
		print("Image is draggable ", image_draggable)
		image.global_position = get_global_mouse_position()
	
	if image_draggable == false:
		image.position.x += moveH
		image.position.y += moveV

func _on_CollisionContainerArea2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
