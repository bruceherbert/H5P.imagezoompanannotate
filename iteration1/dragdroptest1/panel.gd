extends Node2D

onready var isActive = true
var drag_position = null
onready var image = $Image
onready var noZoom = $NoZoom
onready var zoomFactorText = $Zoom_factor_text
onready var zoom_factor = 0.1
onready var sneaky_zoom = 100
const MAX_ZOOM = 0.5
const MIN_ZOOM = 0.1
const PAN_FACTOR = 10
export var initial_zoom = 0.3
onready var current_zoom = initial_zoom
export var image_to_load = "res://images/image1.jpg"
onready var res = load(image_to_load)
var image_draggable = false
const drawItem = preload("res://Draw.tscn")


func _ready():
	updateZoomFactorText()
	initZoom()
	get_node("Image").texture = res

func _on_Image_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			#start drag mode
			drag_position = get_global_mouse_position() - image.rect_global_position
		else:
			#end drag mode
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		# this is the part that makes it move
		image.rect_global_position = get_global_mouse_position() - drag_position
		noZoom.global_position = get_global_mouse_position() -drag_position

func _input(event):
	if isActive:
		if event.is_action_pressed("zoom_in"):
			zoom("in")
		if event.is_action_pressed("zoom_out"):
			zoom("out")
		
		if event.is_action_pressed("draw_rectangle"):
			drawMode("Rectangle")
		if event.is_action_pressed("draw_text"):
			drawMode("Text")

func _process(delta):
	keyboardControl(delta)

func keyboardControl(delta):
	if isActive:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("pan_right") - Input.get_action_strength("pan_left")
		input_vector.y = Input.get_action_strength("pan_down") - Input.get_action_strength("pan_up")
		input_vector = input_vector.normalized()
		var moveH = input_vector.x * PAN_FACTOR
		var moveV = input_vector.y * PAN_FACTOR
		
		if image_draggable:
			print("Image is draggable ", image_draggable)
			image.global_position = get_global_mouse_position()
			noZoom.global_position = get_global_mouse_position()
		
		if image_draggable == false:
			image.rect_position.x += moveH
			image.rect_position.y += moveV
			
			noZoom.global_position.x += moveH
			noZoom.global_position.y += moveV

func _on_Button_draw_rect_pressed():
	drawMode("Rectangle")
	
func _on_Button_draw_text_pressed():
	drawMode("Text")

func _on_Button_zoom_in_pressed():
	zoom("in")

func _on_Button_zoom_out_pressed():
	zoom("out")

func zoom(direction):
	if direction == "in":
		if current_zoom < MAX_ZOOM:
			print("IN current zoom: ",current_zoom)
			current_zoom += zoom_factor
			image.rect_scale.x = current_zoom
			image.rect_scale.y = current_zoom
			noZoom.position.x -= global_position.x + sneaky_zoom * current_zoom
			noZoom.position.y -= global_position.y + sneaky_zoom  * current_zoom
	if direction == "out":
		if current_zoom > MIN_ZOOM:
			print("OUT current zoom: ",current_zoom)
			current_zoom -= zoom_factor
			image.rect_scale.x = current_zoom
			image.rect_scale.y = current_zoom
			noZoom.position.x += global_position.x + sneaky_zoom  * current_zoom
			noZoom.position.y += global_position.y + sneaky_zoom  * current_zoom
	updateZoomFactorText()

func initZoom():
	image.rect_scale.x = initial_zoom
	image.rect_scale.y = initial_zoom
	
func updateZoomFactorText():
	zoomFactorText.text = str("Zoom: ", current_zoom)


func drawMode(type):
	var newItem = drawItem.instance()
	newItem.init(type)

	if type == "Rectangle":
		image.add_child(newItem)
	if type == "Text":
		noZoom.add_child(newItem)
	
	newItem.global_position = get_global_mouse_position()
	# EDIT edit placement
	# 
