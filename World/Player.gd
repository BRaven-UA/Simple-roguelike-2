tool
extends World_Object

class_name Player

export (int) var vision_range = 1
var explored_area: TileMap
var objects: TileMap
var camera: Camera2D
var explored_tile: int
export var test := false setget test

func test(n):
#	print(get_tree().edited_scene_root.name)
#	Global.scene = get_tree().edited_scene_root
#	print(Global.world.name)
	print(get_viewport().canvas_transform)

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
	explored_tile = explored_area.tile_set.find_tile_by_name("Explored")
	move_to_tile(tile_position)

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("move_up"):
		move_to_tile(tile_position + Vector2.UP)
	if event.is_action_pressed("move_down"):
		move_to_tile(tile_position + Vector2.DOWN)
	if event.is_action_pressed("move_left"):
		move_to_tile(tile_position + Vector2.LEFT)
	if event.is_action_pressed("move_right"):
		move_to_tile(tile_position + Vector2.RIGHT)
	

func move_to_tile(new_position: Vector2):
	.move_to_tile(new_position)
	_explore_area()
	if camera and new_position != Vector2.INF:
		camera.move_to(objects.map_to_world(new_position) + Vector2(64, 64))

func _explore_area():
	if explored_area:
		for y in range(tile_position.y - vision_range, tile_position.y + vision_range + 1):
			for x in range(tile_position.x - vision_range, tile_position.x + vision_range + 1):
				explored_area.set_cell(x, y, explored_tile)
