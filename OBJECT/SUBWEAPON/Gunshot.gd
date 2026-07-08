extends Area2D


var damage = 3
var own = Global.player1




func _ready():
	Global.ammo -= 1
	$AnimatedSprite.play("default")
	$AnimatedSprite.frame = 0
	pass
	
	


func _on_AnimatedSprite_animation_finished():
	queue_free()
	pass
