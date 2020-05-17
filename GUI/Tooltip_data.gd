extends Resource

class_name TooltipData

export var caption:String
export var description:String
export var debug_info:String
export var delay: float = 1.0

func is_empty() -> bool:
	var stack := caption + description
	if Global.tooltip.debug_mode:
		stack += debug_info
	return stack.empty()
