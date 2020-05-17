extends GUI_Window

const FULL_SIZE = Vector2(256, 256)

onready var tween: Tween = $Tween
onready var player: Player = Global.player
onready var _body_parts = find_node("BodyParts")

func _ready():
	_close_button.visible = false	# this window cannot be closed this way

func event_begin(event_data: Dictionary):
	player.busy = true
	_content.get_node("Event_Image").texture.region = event_data.Texture_region
	
	var event_holder = event_data.Holder
	if event_holder is Creature:
		var body_parts = event_holder.get_body_parts()
		for i in body_parts.size():
			_body_parts.get_child(i).body_part = body_parts[i]
	
	var rect = Rect2()
	if last_rect:
		rect = last_rect
	else:
#		rect.position = gui.window_world.rect_position + event_data.Rect.position - (FULL_SIZE - rect_size)/2
		rect.position = gui.window_world.rect_position
		rect.size = FULL_SIZE
	modulate.a = 0.0
#	tween.interpolate_property(self, "rect_position", event_data.Rect.position, rect.position, 0.7, Tween.TRANS_LINEAR)
	tween.interpolate_property(self, "rect_position", gui.window_world.rect_position + gui.window_world.rect_size / 2, rect.position, 0.7, Tween.TRANS_LINEAR)
#	tween.interpolate_property(self, "rect_size", event_data.Rect.size, rect.size, 0.7, Tween.TRANS_LINEAR)
	tween.interpolate_property(self, "rect_size", Vector2.ZERO, rect.size, 0.7, Tween.TRANS_LINEAR)
	tween.interpolate_property(self, "modulate:a", 0.05, 1.0, 0.7, Tween.TRANS_LINEAR)
	tween.start()
	visible = true

func event_end():
	visible = false
	player.busy = false
	for node in _body_parts.get_children():
		node.visible = false

func _on_Button_pressed() -> void:
	event_end()
