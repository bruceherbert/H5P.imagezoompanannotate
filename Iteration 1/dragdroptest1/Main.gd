extends Node

onready var paneA = $TabContainer/VIEW/VBoxContainer/Viewports/Tree/paneA
onready var paneB = $TabContainer/VIEW/VBoxContainer/Viewports/Tree2/paneB
onready var captured_image = $TabContainer/EXPORT/CapturedImage

func _ready():
	panel_active(true, false)

func _on_Button_Pane_A_active_pressed():
	panel_active(true, false)

func _on_Button_Pane_B_active_pressed():
	panel_active(false, true)

func panel_active(paneA_active, paneB_active):
	if paneA_active && !paneB_active:
		paneA.isActive = true
		paneB.isActive = false
	if !paneA_active && paneB_active:
		paneA.isActive = false
		paneB.isActive = true
	if !paneA_active && !paneB_active:
		paneA.isActive = false
		paneB.isActive = false
		
func _input(event):
	if event.is_action_pressed("paneA_active"):
		panel_active(true, false)
	if event.is_action_pressed("paneB_active"):
		panel_active(false, true)

func _on_CaptureButton_pressed():
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	# Wait until the frame has finished before getting the texture.
	yield(VisualServer, "frame_post_draw")

	# Retrieve the captured image.
	var img = get_viewport().get_texture().get_data()

	# Flip it on the y-axis (because it's flipped).
	img.flip_y()

	# Create a texture for it.
	var tex = ImageTexture.new()
	tex.create_from_image(img)

	# Set the texture to the captured image node.
	captured_image.set_texture(tex)
