extends Area2D
class_name TrickRing

@export var prizegetter:Node

func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		Global.score += 500 
		Global.chain += 1
		Global.chaintime = Global.chaintimereset
		$Anim.play("Clear")
		Global.ringplayer.play()
		Global.ringplayer.pitch_scale += 0.15
	
	if prizegetter != null:
		prizegetter.active = true
		prizegetter.rings.pop_back()
