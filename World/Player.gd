tool
extends World_Object

class_name Player

export (int) var vision_range = 1
var explored_area: TileMap
var objects: TileMap
var camera: Camera2D
var move_direction: Vector2
export var test := false setget test

func test(n):
	pass

func _enter_tree():
	Global.player = self
#	if Engine.editor_hint:
#		var world = find_parent("World")
#		explored_area = world.find_node("ExploredArea")
#		objects = world.find_node("Objects")

func _ready():
	Global.world.connect("world_is_ready", self, "_on_world_ready")

func _on_world_ready():
	explored_area = Global.world.explored_area
	objects = Global.world.objects
	camera = Global.world.camera
	move_to_tile(tile_position)

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("move_up"):
		move_direction += Vector2.UP
	if event.is_action_pressed("move_down"):
		move_direction += Vector2.DOWN
	if event.is_action_pressed("move_left"):
		move_direction += Vector2.LEFT
	if event.is_action_pressed("move_right"):
		move_direction += Vector2.RIGHT
	
	if event.is_action_released("move_up") or event.is_action_released("move_down") or event.is_action_released("move_left") or event.is_action_released("move_right"):
		if can_move(tile_position + move_direction):
			move_to_tile(tile_position + move_direction)
			move_direction = Vector2.ZERO
	
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var tile_pos= tilemap.world_to_map(tilemap.get_global_mouse_position())
		if can_move(tile_pos):
			move_to_tile(tile_pos)
			move_direction = Vector2.ZERO

func can_move(pos: Vector2) -> bool:
	return (tile_position.distance_to(pos) < 1.5)	# can move on neighbors only

func move_to_tile(new_position: Vector2):
	.move_to_tile(new_position)
	_explore_area()
	if camera and new_position != Vector2.INF and not Engine.editor_hint:
		camera.move_to(objects.map_to_world(new_position) + Vector2(64, 64))

func _explore_area():
	if explored_area:
		for y in range(tile_position.y - vision_range, tile_position.y + vision_range + 1):
			for x in range(tile_position.x - vision_range, tile_position.x + vision_range + 1):
				explored_area.set_cell(x, y, TILE.Explored)
