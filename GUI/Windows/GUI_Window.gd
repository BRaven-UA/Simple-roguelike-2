extends Control

class_name GUI_Window

const GROUP_NAME := "Windows"

onready var gui = Global.gui
onready var _aura := $Aura	# link to the aura node
onready var _border := $Border	# link to the border node
onready var _resize_corner := $ResizeCorner	# link to the resize corner node
onready var _close_button := $CloseButton
onready var _content := $Content	# link to the content node
export var tooltip_data: Resource = TooltipData.new()	#actually it's TooltipData resource, which cannot be exported yet (as custom class)
var last_rect: Rect2
var selected := false setget _select

func _ready():
	add_to_group(GROUP_NAME)
	
	# connects children's inputs
	_border.connect("gui_input", self, "_border_input")
	_resize_corner.connect("gui_input", self, "_resize_corner_input")
	_close_button.connect("gui_input", self, "_close_button_input")
	_close_button.connect("pressed", self, "_close")
	_content.connect("gui_input", self, "_content_input")
	
	if not tooltip_data:
		tooltip_data = TooltipData.new()

func _select(state := true):
	if selected != state:
		selected = state
		_aura.visible = selected
		if selected:
			raise()
		else:
			last_rect = get_rect()

func _border_input(event: InputEvent):
	# checks mouse motion along with left button pressed to drag this window
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		_select()
#		var new_position = rect_position + event.relative
#		if not find_intersection(Rect2(new_position, rect_size)):
#			rect_position = new_position
		rect_position += event.relative
		rect_position = Global.match_screen(get_rect())

func _resize_corner_input(event: InputEvent):
	# checks mouse motion along with left button pressed to resize this window
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		_select()
		rect_size += event.relative

func _close_button_input(event: InputEvent):
	if event is InputEventMouseMotion:
		_close_button.raise()

func _close():
	# TODO: should move this window to the window stack
	visible = false

func _content_input(event: InputEvent):
	# redirects inputs of content
	if event is InputEventMouseMotion and Input.get_mouse_button_mask() == 0:
		_content.raise()
		if event.relative:	# BUG: workaround for Windows bug when InputEventMouseMotion generated on mouse buttons release (https://github.com/godotengine/godot/issues/20357)
			Global.tooltip.data = tooltip_data

func _input(event: InputEvent):
	if event is InputEventMouseButton and not event.is_pressed():
		_select(false)
		uncover_windows()

func uncover_windows():	# brings to front all underlaying windows
	for window in get_tree().get_nodes_in_group(GROUP_NAME):
		if window != self and get_rect().grow(20).encloses(window.get_rect()):	# the gap for leaving behind
			window.raise()
			window.uncover_windows()

#func find_intersection(rect: Rect2 = get_rect()) -> Rect2:
#	var result : Rect2
#	for window in get_tree().get_nodes_in_group(GROUP_NAME):
#		if window != self:
#			var rect2 = window.get_rect()
#			if rect2.intersects(rect):
#				result = rect2
#				break
#	return result
