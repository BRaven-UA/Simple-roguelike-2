tool
extends EditorScript

const MAX = Color(0, 0.5, 0)
const MIN = Color(0.5, 0, 0)

func _run():
#	var _bar = get_scene().find_node("ProgressBar")
#	_bar.get("custom_styles/fg").bg_color = Color.from_hsv(lerp(0, 0.333, 15 / 30), 1, 0.5)
	print(lerp(0, 0.333, 0.5))
