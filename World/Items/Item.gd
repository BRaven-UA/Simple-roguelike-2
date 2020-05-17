extends Node

class_name Item

var item_name: String setget _set_item_name
var item_owner: Node

func _set_item_name(new_value):
	item_name = new_value
	name = new_value

func _init(values = {}):
	_fill_properties(values)

func _fill_properties(values: Dictionary):
	for key in values.keys():
		set("item_%s" %key, values[key])

func _enter_tree():
	item_owner = get_parent()

func destroy():
	print(name, " has been destroyed")
	queue_free()
