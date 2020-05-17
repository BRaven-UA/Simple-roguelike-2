extends HBoxContainer

#const MAX_COLOR = Color(0, 0.5, 0)
#const MIN_COLOR = Color(0.5, 0, 0)

onready var _icon = $Icon
onready var _bar = $ProgressBar
onready var _label = $ProgressBar/Text
onready var _bar_foreground = _bar.get("custom_styles/fg")

var body_part: Item_BodyPart setget set_body_part

func set_body_part(new_body_part: Item_BodyPart):
#	if new_body_part != body_part:
		body_part = new_body_part
		if body_part:
			body_part.connect("structure_changed", self, "update_structure")
			_bar.max_value = body_part.item_max_structure
			update_structure()
			visible = true

func update_structure():
	_bar.value = body_part.item_structure
	_bar_foreground.bg_color = Color.from_hsv(lerp(0, 0.333, body_part.item_structure / float(body_part.item_max_structure)), 1, 0.5)	# from red to green via yellow
	_label.text = "%s %d/%d" %[body_part.item_name, body_part.item_structure, body_part.item_max_structure]
