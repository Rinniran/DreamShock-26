extends Label

func _process(delta: float) -> void:
	text = str(Global.kills) + str("/8")
