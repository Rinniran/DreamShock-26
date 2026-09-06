extends Node2D

func _process(delta: float) -> void:
	if !is_instance_valid($Odachi/Area2D):
		queue_free()
