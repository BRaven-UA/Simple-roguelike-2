tool
extends Node

const DataBase = [
	{"class": Item_BodyPart, "name":"Head", "max_structure":30},
	{"class": Item_BodyPart, "name":"Torso", "max_structure":100},
	{"class": Item_BodyPart, "name":"Legs", "max_structure":60},
	{"class": Item_BodyPart, "name":"Arms", "max_structure":50}
	]

func create_custom_item(item: Dictionary, owner: Node):
	assert(item and owner)
	owner.add_child(item.class.new(item))

func create_default_item(name: String, owner: Node):
	assert(name and owner)
	var default_item = get_default_item(name)
	create_custom_item(default_item, owner)

func get_default_item(name: String) -> Dictionary:
	var result
	for item in DataBase:
		if item.name == name:
			result = item.duplicate()
			break
	assert(result, "Item '%s' not found" % name)
	return result
