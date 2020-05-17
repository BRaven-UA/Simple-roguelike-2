tool
extends Creature

class_name Player

export var vision_range: int = 1
var explored_area: TileMap
var on_top_area: TileMap
var objects: TileMap
var move_direction: Vector2
export var test := false setget test

func _set_busy(new_value):
	._set_busy(new_value)
	set_process_unhandled_input(not new_value)	# blocks player's control

func test(n):
#	ItemDb.create_item("Torso", $Body)
	pass

func _init():
	change_position(Vector2.ZERO)	# to overwrite INF value (cannot be set via export)

func _enter_tree():
	Global.player = self
#	if Engine.editor_hint:
#		var world = find_parent("World")
#		explored_area = world.find_node("ExploredArea")
#		objects = world.find_node("Objects")
	pass

func _on_world_ready():
	._on_world_ready()
	explored_area = Global.world.explored_area
	on_top_area = Global.world.on_top_area
	objects = Global.world.objects
	change_position(position)
	ItemDb.create_default_item("Torso", _body)
	ItemDb.create_default_item("Head", _body)
	ItemDb.create_default_item("Arms", _body)
	ItemDb.create_default_item("Legs", _body)

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("move_up"):
		move_direction += Vector2.UP
	if event.is_action_pressed("move_down"):
		move_direction += Vector2.DOWN
	if event.is_action_pressed("move_left"):
		move_direction += Vector2.LEFT
	if event.is_action_pressed("move_right"):
		move_direction += Vector2.RIGHT
	
	if event.is_action("move_up") or event.is_action("move_down") or event.is_action("move_left") or event.is_action("move_right"):
		if event.is_pressed():
			if not event.is_echo():
				on_top_area.highlighted_cell = position + move_direction
		else:
			if move_direction and can_move(position + move_direction):
				change_position(position + move_direction)
				move_direction = Vector2.ZERO
#	if event.is_action_released("move_up") or event.is_action_released("move_down") or event.is_action_released("move_left") or event.is_action_released("move_right"):
#		if can_move(position + move_direction):
#			change_position(position + move_direction)
#			move_direction = Vector2.ZERO
	
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var tile_pos= tilemap.world_to_map(tilemap.get_global_mouse_position())
		if can_move(tile_pos):
			change_position(tile_pos)
			move_direction = Vector2.ZERO

func can_move(pos: Vector2) -> bool:
	return (position.distance_to(pos) < 1.5)	# can move on neighbors only

func change_position(new_position: Vector2):
	.change_position(new_position)
	if camera and new_position != Vector2.INF and not Engine.editor_hint:
		camera.move_to(objects.map_to_world(new_position) + Vector2(world.CELL_SIZE.OBJECT / 2, world.CELL_SIZE.OBJECT / 2))
		self.busy = true
		yield(camera.tween, "tween_all_completed")
		self.busy = false
	_explore_area()
	if world:
		var object = world.object_on_cell(new_position)
		if object:
			object.event()

func _explore_area():
	if explored_area:
		for y in range(position.y - vision_range, position.y + vision_range + 1):
			for x in range(position.x - vision_range, position.x + vision_range + 1):
				explored_area.set_cell(x, y, TILE.Explored)

func event():
	pass
