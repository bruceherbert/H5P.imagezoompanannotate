extends Node2D

onready var isActive = false
onready var image = $Image
onready var noZoom = $NoZoom
onready var zoomFactorText = $Zoom_factor_text
onready var zoom_factor = 0.1
onready var sneaky_zoom = 27
const MAX_ZOOM = 0.5
const MIN_ZOOM = 0.1
const PAN_FACTOR = 10
export var initial_zoom = 0.3
onready var current_zoom = initial_zoom
var image_draggable = false
const drawItem = preload("res://Draw.tscn")

export var image_to_load = "res://images/image1.jpg"
onready var res = load(image_to_load) # resource is loaded when line is executed

var cursor_target = load("res://cursors/cursor_target.png")
var cursor_drag = load("res://cursors/cursor_drag.png")

func _ready():
	updateZoomFactorText()
	initZoom()
	get_node("Image").texture = res
	#Input.set_custom_mouse_cursor(cursor_drag)
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	print("area just clicked")
	if isActive:
		if Input.is_action_just_pressed("click"):
			image_draggable = true
func _on_Button_zoom_in_pressed():
	if isActive:
		zoom("in")

func _on_Button_zoom_out_pressed():
	if isActive:
		zoom("out")

func _on_Button_draw_rect_pressed():
	drawMode("Rectangle")

func _on_Button_draw_text_pressed():
	drawMode("Text")

func _input(event):
	if isActive:
		if event.is_action_pressed("zoom_in"):
			zoom("in")
		if event.is_action_pressed("zoom_out"):
			zoom("out")
		if event is InputEventMouseButton:
			print("clicking", event.button_index)
			if event.button_index == BUTTON_LEFT and not event.pressed:
				print("is this happening?")
				image_draggable = false
		if event.is_action_pressed("draw_rectangle"):
			drawMode("Rectangle")
		if event.is_action_pressed("draw_text"):
			drawMode("Text")

func _process(delta):
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
		
		if image_draggable == false:
			image.position.x += moveH
			image.position.y += moveV
			noZoom.position.x += moveH
			noZoom.position.y += moveV

func zoom(direction):
	if direction == "in":
		if current_zoom < MAX_ZOOM:
			print("IN current zoom: ",current_zoom)
			current_zoom += zoom_factor
			image.scale.x = current_zoom
			image.scale.y = current_zoom
			noZoom.position.x -= sneaky_zoom
			noZoom.position.y -= sneaky_zoom
	if direction == "out":
		if current_zoom > MIN_ZOOM:
			print("OUT current zoom: ",current_zoom)
			current_zoom -= zoom_factor
			image.scale.x = current_zoom
			image.scale.y = current_zoom
			noZoom.position.x += sneaky_zoom
			noZoom.position.y += sneaky_zoom
	updateZoomFactorText()

func initZoom():
	image.scale.x = initial_zoom
	image.scale.y = initial_zoom
	
func updateZoomFactorText():
	zoomFactorText.text = str("Zoom: ", current_zoom)

func drawMode(type):
	# MODES:
	# PLACEMENT
	# change cursor to + 
	# placement/size - changes 
	# 
	# get origin anchor
	
	Input.set_custom_mouse_cursor(cursor_target)
	
	# if it is 
	
	var newItem = drawItem.instance()
	newItem.init(type)

	if type == "Rectangle":
		image.add_child(newItem)
	if type == "Text":
		noZoom.add_child(newItem)
	newItem.global_position = get_global_mouse_position()



	# EDIT edit placement
	# 
	#
