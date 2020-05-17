tool
extends Node

class_name World_Object

enum TILE {Explored = 2, Unknown, Player, Insect, Repair, Scorpid, Highlight, Can_move, Cannot_move}

export (TILE) var object_tile := TILE.Unknown setget _set_tile
export (String) var object_name := "Noname" setget _set_name
export (Vector2) var position setget change_position	# see _init() comment for details
export (bool) var hidden := false
var busy :bool setget _set_busy
var tilemap: TileMap	# parent tilemap, mostly 'Objects'
onready var gui = Global.gui
onready var world = Global.world
var camera: Camera2D

func _set_tile(new_value):
	if is_inside_tree():
		self.object_name = get_parent().tile_set.tile_get_name(new_value)
	object_tile = new_value

func _set_name(new_value):
	name = new_value
	object_name = new_value

func _set_busy(new_value):	#supposed to be overridden by inheritor
	busy = new_value

func _init():
	if not Engine.editor_hint:
		change_position(Vector2.INF)	# BUG: it causes compilation error in .tscn file when declared as initial value

func _enter_tree():
	tilemap = get_parent()
	change_position(position)

func _exit_tree():
	tilemap.set_cellv(position, -1)

func _ready():
	world.connect("world_is_ready", self, "_on_world_ready")

func _on_world_ready():
	camera = Global.world.camera

func change_position(new_position: Vector2):
	if Engine.editor_hint:
		tilemap = get_parent()
	if tilemap and not busy:
		if position != Vector2.INF:
			tilemap.set_cellv(position, -1)
		if not hidden and new_position != Vector2.INF:
			tilemap.set_cellv(new_position, object_tile)
	position = new_position

func event():
	self.busy = true
#	var event_data = {"Rect": Rect2()}
	var event_data = {}
	event_data.Holder = self
#	event_data.Rect.position = world.get_viewport_transform().xform(tilemap.map_to_world(position))
#	event_data.Rect.size = Vector2(world.CELL_SIZE.OBJECT, world.CELL_SIZE.OBJECT) / camera.zoom
	event_data.Texture_region = tilemap.tile_set.tile_get_region(object_tile)
	gui.window_event.event_begin(event_data)
