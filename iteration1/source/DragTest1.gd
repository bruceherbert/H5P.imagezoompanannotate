extends Node2D

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	 if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)


func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	print("start drag")
