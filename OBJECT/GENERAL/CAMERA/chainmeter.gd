extends TextureProgressBar

func _process(delta: float) -> void:
	max_value = Global.chaintimereset
	value = Global.chaintime
