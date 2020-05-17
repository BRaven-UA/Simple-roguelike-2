tool
extends MarginContainer

class_name GUI_Tooltip

onready var _caption: Label = find_node("Caption")
onready var _delimeter: TextureRect = find_node("Delimeter")
onready var _description: Label = find_node("Description")
onready var _debug_info: Label = find_node("DebugInfo")
onready var _timer: Timer = $Timer
var data : TooltipData setget _set_data
var debug_mode := false

func _enter_tree():
	Global.tooltip = self

func _ready():
	_timer.connect("timeout", self, "show_tooltip")

func _input(event: InputEvent):
	if event is InputEventMouse:
		_timer.stop()
		data = TooltipData.new()	# clear tooltip data
		set_deferred("visible", false)
	
	if event.is_action("debug_mode_tooltip") and not event.is_echo():
		debug_mode = event.is_pressed()
		show_tooltip()	# refresh tooltip with new state

func _set_data(new_data: TooltipData):
	data = new_data
	if not data.delay:
		show_tooltip()
	else:
		if _timer.is_stopped():
			_timer.start(data.delay)

func show_tooltip():
	_set_label_text(_caption, data.caption)
	_set_label_text(_description, data.description)
	_set_label_text(_debug_info, data.debug_info)
	_delimeter.visible = (data.caption and data.description)
	rect_size = Vector2.ZERO	# forces size updating to fit its content
	rect_position = Global.match_screen(Rect2(get_global_mouse_position() + Vector2(20, 0), rect_size))
	set_deferred("visible", not data.is_empty())

func _set_label_text(label: Label, text: String = ""):
	var font: Font = label.get("custom_fonts/font")
	var size = font.get_string_size(text)
	label.rect_min_size = font.get_wordwrap_string_size(text, clamp(size.x + 10, 50, 250))
	label.text = text
	label.visible = bool(text)
	if label == _debug_info:
		label.visible = (label.visible and debug_mode)
