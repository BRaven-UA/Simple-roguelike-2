tool
extends Node

class_name World_Object

enum TILE {Explored = 2, Unknown, Player, Insect, Repair, Scorpid, Highlight, Can_move, Cannot_move}
#
export (TILE) var object_tile := TILE.Unknown setget _set_tile
export (String) var object_name := "Noname" setget _set_name
export (Vector2) var tile_position := Vector2.INF setget move_to_tile
var tilemap: TileMap

func _set_tile(new_value):
	if is_inside_tree():
		self.object_name = get_parent().tile_set.tile_get_name(new_value)
	object_tile = new_value

func _set_name(new_value):
	name = new_value
	object_name = new_value

func _enter_tree():
	tilemap = get_parent()
	move_to_tile(tile_position)

func _exit_tree():
	tilemap.set_cellv(tile_position, -1)

func move_to_tile(new_position: Vector2):
	if Engine.editor_hint:
		tilemap = get_parent()
	if tilemap and new_position != Vector2.INF:
		if tile_position != Vector2.INF:
			tilemap.set_cellv(tile_position, -1)
		tilemap.set_cellv(new_position, object_tile)
	tile_position = new_position
