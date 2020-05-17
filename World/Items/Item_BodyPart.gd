extends Item

class_name Item_BodyPart

signal structure_changed

var item_max_structure: int = 1
var item_structure: int = 1 setget _set_structure	# the item's 'health'
var item_scrap: int	# the amount of scrap-metal remaining after destruction

func _init(values = {}).(values):
	if values:
		item_structure = values.max_structure
		item_scrap = values.max_structure / 2

func _set_structure(new_value: int):
	new_value = int(clamp(new_value, 0, item_max_structure))
	if new_value != item_structure:
		item_structure = new_value
		emit_signal("structure_changed")
		if not item_structure:
			destroy()

func _enter_tree():
	item_owner = get_node("../..")
