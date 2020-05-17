extends TileMap

onready var player: Player = Global.player
onready var player_tile: int = tile_set.find_tile_by_name("Player")
var highlighted_cell: Vector2 setget _set_highlighted_cell

func _set_highlighted_cell(new_value: Vector2):
	if highlighted_cell != player.position:
		set_cellv(highlighted_cell, -1)
	if new_value != player.position:
		set_cellv(new_value, World_Object.TILE.Can_move if player.can_move(new_value) else World_Object.TILE.Highlight)
		highlighted_cell = new_value

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
#		var mouse = mouse_to_pos()
#		if highlighted_cell != player.position:
#			set_cellv(highlighted_cell, -1)
#		if mouse != player.position:
#			set_cellv(mouse, World_Object.TILE.Can_move if player.can_move(mouse) else World_Object.TILE.Highlight)
#			highlighted_cell = mouse
		_set_highlighted_cell(mouse_to_pos())
#		set_cell_except(mouse, "Highlight")
#		if player.can_move(mouse):
#			set_cell_except(mouse, "Can_move")

func mouse_to_pos() -> Vector2:
	return world_to_map(get_global_mouse_position())

#func set_cell_except(pos: Vector2, tile_name: String):
#	var tile = tile_set.find_tile_by_name(tile_name)
#	if tile:
#		for cell in get_used_cells_by_id(tile):
#			set_cellv(cell, -1)
#		if get_cellv(pos) != player_tile:
#			set_cellv(pos, tile)
