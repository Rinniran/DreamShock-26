extends Area2D
var damage = 2
@onready var anim = $AnimationPlayer


func _ready() -> void:
	Global.ammo -= 1
	var rng = randi_range(0,1)
	match (rng):
		0:
			anim.play("SwingDown")
		1:
			anim.play("SwingUp")
