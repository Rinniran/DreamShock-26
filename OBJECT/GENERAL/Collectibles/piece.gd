extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if $sp.animation != "collect" && area.is_in_group("Player"):
		Global.pieces += 1
		if Global.pieces >= 100:
			Global.p1health += 1
			Global.pieces = 0
		$sp.play("collect")


func _on_sp_animation_finished() -> void:
	if $sp.animation == "collect":
		queue_free()
