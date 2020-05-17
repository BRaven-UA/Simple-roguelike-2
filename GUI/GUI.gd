extends Control

class_name GUI

onready var window_world: GUI_Window = $Window_World
onready var window_event: GUI_Window = $Window_Event

func _enter_tree():
	Global.gui = self
