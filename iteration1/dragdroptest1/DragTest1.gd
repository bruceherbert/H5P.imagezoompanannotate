extends Node2D

var selected = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	# this part is for the SELECT
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	# this part is for the MOVE
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event):
	# this part is for the DROP
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
