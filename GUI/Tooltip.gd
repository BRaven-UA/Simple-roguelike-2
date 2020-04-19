tool
extends MarginContainer

class_name GUI_tooltip

onready var _caption = find_node("Caption")
onready var _description = find_node("Description")
onready var _delimeter = find_node("Delimeter")
var data : TooltipData setget show_tooltip
var data_template := TooltipData.new()

func _enter_tree():
	Global.tooltip = self
#	connect("item_rect_changed", self, "_on_rect_changed")

func _input(event: InputEvent):
	if event is InputEventMouse:
		set_deferred("visible", false)

#func _unhandled_input(event: InputEvent):
#	if event is InputEventMouseMotion:
#		Global.tooltip.visible = false

#func get_template() -> Dictionary:
#	return TEMPLATE.duplicate()

func show_tooltip(data: TooltipData):
#	data = new_data
	if not data.is_empty():
		_caption.text = data.caption
		_caption.visible = bool(data.caption)
		_description.text = data.description
		_description.visible = bool(data.description)
		_delimeter.visible = (data.caption and data.description)
		rect_size = Vector2.ZERO	# forces size updating to fit its content
		rect_position = Global.match_screen(Rect2(get_global_mouse_position() + Vector2(20, 0), rect_size))
		set_deferred("visible", true)

#func _on_rect_changed():
#	rect_position = Global.match_screen(get_rect())
