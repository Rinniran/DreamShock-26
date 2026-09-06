extends Area2D

@onready var blspr = preload("uid://dt1git4x7377f")
@onready var sh = preload("uid://d0uuludl0qtb1")


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pl_Attack"):
		var b = blspr.instantiate()
		get_parent().add_child(b)
		SoundEngine.playsound(3,sh, -4)
		area.queue_free()
