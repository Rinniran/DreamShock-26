extends Area2D

@export var activate_cutscene:Node = null

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Global.camera.locked = true
		if activate_cutscene != null:
			activate_cutscene.active = true
		queue_free()
