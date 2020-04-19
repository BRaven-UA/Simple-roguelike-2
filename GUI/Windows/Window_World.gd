extends GUI_Window

onready var world_viewport: Viewport = find_node("Viewport")
onready var world := Global.world

func _content_input(event: InputEvent):
	world_viewport.unhandled_input(event)
#	tooltip_data.caption = String(world_viewport.get_mouse_position())
#	print(world.get_global_mouse_position())
	tooltip_data.caption = world.get_tile_name()
	._content_input(event)
