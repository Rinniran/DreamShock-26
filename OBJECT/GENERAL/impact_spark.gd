extends AnimatedSprite2D

@export var create_object:PackedScene

func _on_animation_finished() -> void:
	if create_object != null:
		var obj = create_object.instantiate()
		obj.global_position = global_position
		get_parent().add_child(obj)
	queue_free()
