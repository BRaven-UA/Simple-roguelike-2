extends Resource

class_name TooltipData

export var caption := ""
export var description := ""
export var debug_info := ""

func is_empty() -> bool:
	var stack := caption + description
	if Global.tooltip.debug_mode:
		stack += debug_info
	return stack.empty()
