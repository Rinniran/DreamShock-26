extends BaseState

func _enter(data = {}):
	root.anim.play("Move")
	if root.position.distance_to(Global.player1.position) > 200:
		root.sprite.flip_h = !root.sprite.flip_h
	else:
		if Global.player1.position.x < root.position.x:
			root.sprite.flip_h = false
		else:
			root.sprite.flip_h = true
	
func _step():
	super()
	root.velocity.x = 0
	if root.sprite.flip_h == false:
		if root.gdl.is_colliding():
			root.velocity.x = -root.speed
		else:
			parent.change_state("Idle")
	else:
		if root.gdr.is_colliding():
			root.velocity.x = root.speed
		else:
			parent.change_state("Idle")
	if parent.state_time >= 60:
		parent.change_state("Idle")
	
	if root.position.distance_to(Global.player1.position) < 200:
		parent.change_state("Attack")
	


func _exit(next_state):
	super(next_state)
