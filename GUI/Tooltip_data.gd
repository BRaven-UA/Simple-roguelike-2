extends Resource

class_name TooltipData

export var caption := ""
export var description := ""

func is_empty() -> bool:
	return not bool(caption + description)
