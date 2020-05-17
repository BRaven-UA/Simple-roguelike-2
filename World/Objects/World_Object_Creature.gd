tool
extends World_Object

class_name Creature

var _body: Node
var _inventory: Node

func _ready():
	_body = Node.new()
	_body.name = "Body"
	add_child(_body)
	_inventory = Node.new()
	_inventory.name = "Inventory"
	add_child(_inventory)
	
	#for debug
	if object_name == "Insect":
		ItemDb.create_default_item("Torso", _body)
		ItemDb.create_default_item("Head", _body)
		ItemDb.create_default_item("Legs", _body)


func get_body_parts() -> Array:
	return _body.get_children()
