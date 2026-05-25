extends Sprite2D

var shotcool = 0


func _physics_process(delta: float) -> void:
	
	
	if shotcool > 0:
		shotcool -= 1
	
	if Input.is_action_pressed("PAD1_B") && visible == true:
		if shotcool <= 0:
			shoot()
			shotcool = 5

func shoot():
	var pj1 = preload("res://OBJECT/Projectiles/Player/PR_Floof.tscn").instantiate()
	pj1.direction.x = 1
	pj1.position = position
	
	get_parent().add_child(pj1)
