extends Area2D
class_name Piece

@onready var col = $collect

func _on_area_entered(area: Area2D) -> void:
	if $sp.animation != "collect" && area.is_in_group("Player"):
		Global.addcombo()
		Global.score += 10 * (Global.chain)
		Global.pieces += 1
		Global.ms = 0
		if Global.pieces >= 100:
			Global.p1health += 1
			Global.p1lives += 1
			Global.pieces = 0
			
			
		$sp.play("collect")
		SoundEngine.playsound(4,col.stream,col.volume_db)


func _on_sp_animation_finished() -> void:
	if $sp.animation == "collect":
		queue_free()
