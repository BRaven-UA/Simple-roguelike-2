tool
extends Node2D

class_name GameWorld

signal world_is_ready

onready var explored_area := $ExploredArea
onready var objects := $Objects
onready var on_top_area := $OnTopArea
onready var camera := $Camera2D
onready var highlight_tile: int = on_top_area.tile_set.find_tile_by_name("Highlight")
var highlighted_cell: Vector2

func _enter_tree():
	Global.world = self

func _ready():
	emit_signal("world_is_ready")
#
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if on_top_area.get_cellv(highlighted_cell) == highlight_tile:
			on_top_area.set_cellv(highlighted_cell, -1)
		var mouse = get_global_mouse_position()
		var tile_pos = on_top_area.world_to_map(mouse)
		if on_top_area.get_cellv(tile_pos) == -1:
			on_top_area.set_cellv(tile_pos, highlight_tile)
			highlighted_cell = tile_pos

func get_tile_name() -> String:
	var mouse = get_global_mouse_position()
	var tile_pos = explored_area.world_to_map(mouse)
	var tile_idx = explored_area.get_cellv(tile_pos)
	var object_idx = objects.get_cellv(tile_pos)
	var tile_name = objects.tile_set.tile_get_name(object_idx) if (tile_idx !=-1 and object_idx !=-1) else ""
#	prints("mouse:", mouse, "tile_pos:", tile_pos, "tile_idx", tile_idx, "tile_name", tile_name)
	return tile_name
#	return String(get_local_mouse_position())
