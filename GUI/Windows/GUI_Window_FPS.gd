extends GUI_Window

onready var label = _content.find_node("FPS")

func _physics_process(delta: float):
	label.text = str(Engine.get_frames_per_second())
