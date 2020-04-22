tool
extends Node2D

class_name GameWorld

signal world_is_ready

onready var chunks := $Chunks
onready var explored_area := $ExploredArea
onready var objects := $Objects
onready var on_top_area := $OnTopArea
onready var camera := $Camera2D
onready var highlight_tile: int = on_top_area.tile_set.find_tile_by_name("Highlight")

func _enter_tree():
	Global.world = self

func _ready():
	emit_signal("world_is_ready")
#

func get_tile_info(tooltip_data: TooltipData):
	var mouse = get_global_mouse_position()
	var tile_pos = explored_area.world_to_map(mouse)
	tooltip_data.debug_info = "Position: " + str(tile_pos)
	var tile_idx = explored_area.get_cellv(tile_pos)
	var object_idx = objects.get_cellv(tile_pos)
	tooltip_data.caption = objects.tile_set.tile_get_name(object_idx) if (tile_idx !=-1 and object_idx !=-1) else ""
#	return tile_name
