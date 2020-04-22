tool
extends MarginContainer

class_name GUI_tooltip

onready var _caption: Label = find_node("Caption")
onready var _delimeter: TextureRect = find_node("Delimeter")
onready var _description: Label = find_node("Description")
onready var _debug_info: Label = find_node("DebugInfo")
var data : TooltipData setget show_tooltip
#var data_template := TooltipData.new()
var debug_mode := false

func _enter_tree():
	Global.tooltip = self
#	connect("item_rect_changed", self, "_on_rect_changed")

func _input(event: InputEvent):
	if event is InputEventMouse:
		set_deferred("visible", false)
	
	if event.is_action("debug_mode_tooltip"):
		debug_mode = event.is_pressed()
		if visible:
			show_tooltip(data)	# refresh tooltip with new state

#func _unhandled_input(event: InputEvent):
#	if event is InputEventMouseMotion:
#		Global.tooltip.visible = false

#func get_template() -> Dictionary:
#	return TEMPLATE.duplicate()

func show_tooltip(new_data: TooltipData):
	data = new_data
	if not data.is_empty():
		_set_label_text(_caption, data.caption)
		_set_label_text(_description, data.description)
		_set_label_text(_debug_info, data.debug_info)
		_delimeter.visible = (data.caption and data.description)
		rect_size = Vector2.ZERO	# forces size updating to fit its content
		rect_position = Global.match_screen(Rect2(get_global_mouse_position() + Vector2(20, 0), rect_size))
		set_deferred("visible", true)

func _set_label_text(label: Label, text: String = ""):
	var font: Font = label.get("custom_fonts/font")
	var size = font.get_string_size(text)
	label.rect_min_size = font.get_wordwrap_string_size(text, clamp(size.x + 10, 50, 250))
	label.text = text
	label.visible = bool(text)
	if label == _debug_info:
		label.visible = (label.visible and debug_mode)

#func _on_rect_changed():
#	rect_position = Global.match_screen(get_rect())
