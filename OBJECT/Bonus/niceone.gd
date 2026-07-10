extends Area2D

var text = ""

@onready var label = $CanvasLayer/Label




func _ready():
	label.text = text
	
	$AnimationPlayer.play("niceone")









func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass
