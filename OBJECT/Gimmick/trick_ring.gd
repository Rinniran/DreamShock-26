extends Area2D
class_name TrickRing

@export var prizegetter:Node
@onready var multiplier = $Score/Label

func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		body.rings += 1
		multiplier.text = str("x") + str(body.rings)
		Global.score += 500 * body.rings
		Global.chain += 1
		Global.chaintime = Global.chaintimereset
		$Anim.play("Clear")
		Global.ringplayer.play()
		Global.ringplayer.pitch_scale += 0.15
	
	if prizegetter != null:
		prizegetter.active = true
		prizegetter.rings.pop_back()
