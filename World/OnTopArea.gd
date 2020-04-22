extends TileMap

onready var player: Player = Global.player
onready var player_tile: int = tile_set.find_tile_by_name("Player")
var highlighted_cell: Vector2

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var mouse = mouse_to_pos()
		if highlighted_cell != player.tile_position:
			set_cellv(highlighted_cell, -1)
		if mouse != player.tile_position:
			set_cellv(mouse, World_Object.TILE.Can_move if player.can_move(mouse) else World_Object.TILE.Highlight)
			highlighted_cell = mouse
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
