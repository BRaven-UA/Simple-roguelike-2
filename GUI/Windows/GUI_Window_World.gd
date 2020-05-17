extends GUI_Window

onready var world_viewport: Viewport = find_node("Viewport")
onready var world: GameWorld = Global.world

func _ready():
	_close_button.visible = false	# this window cannot be closed this way

func _content_input(event: InputEvent):
	world_viewport.unhandled_input(event)	# retranslates input events to the World
	world.get_tile_info(tooltip_data)
	._content_input(event)
