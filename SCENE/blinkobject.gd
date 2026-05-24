@tool
extends Label

@export var ticks_to_count = 120
var ticks = ticks_to_count

func _process(delta: float) -> void:
	ticks -= 1
	if ticks <= 0:
		visible = !visible
		ticks = ticks_to_count
