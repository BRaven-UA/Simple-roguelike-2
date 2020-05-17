extends Camera2D

onready var tween = $Tween
var last_position: Vector2

func _unhandled_input(event):

	if event.is_action_pressed("camera_reset"):
		offset = last_position

	if event.is_action_pressed("camera_zoom_in"):
		zoom *= 0.5
		if zoom < Vector2.ONE:
			zoom = Vector2.ONE

	if event.is_action_pressed("camera_zoom_out"):
		zoom *= 1.5

	if event is InputEventMouseMotion and Input.is_action_pressed("camera_free"):
		offset -= event.relative * zoom.x	# смещаем вьюпорт на дельту смещения мыши от предыдущей ее позиции

func move_to(pos: Vector2):
	last_position = pos
	tween.remove_all()
	var tell = tween.tell()
	if tell:
		print(tell)
	tween.interpolate_property(self, "offset", offset, pos, 1.0, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()
