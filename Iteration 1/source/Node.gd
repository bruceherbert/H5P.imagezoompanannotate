extends Node

# Version 1 - image zoom and pan 
# Allows zoom in (up

onready var paneA = $TabContainer/VIEW/Viewports/ViewportContainer1/Viewport1/paneA
onready var paneB = $TabContainer/VIEW/Viewports/ViewportContainer2/Viewport2/paneB

onready var viewport1 = $TabContainer/VIEW/Viewports/ViewportContainer1/Viewport1
onready var viewport2 = $TabContainer/VIEW/Viewports/ViewportContainer2/Viewport2
onready var camera1 = $TabContainer/VIEW/Viewports/ViewportContainer1/Viewport1/Camera2D1
onready var camera2 = $TabContainer/VIEW/Viewports/ViewportContainer2/Viewport2/Camera2D2


func _ready():
	panel_active(true, false)
	camera1.target = paneA.get_node("paneA")

func _on_Button_Pane_A_active_pressed():
	panel_active(true, false)

func _on_Button_Pane_B_active_pressed():
	panel_active(false, true)
	
func _input(event):
	if event.is_action_pressed("paneA_active"):
		panel_active(true, false)
	if event.is_action_pressed("paneB_active"):
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
