extends BaseState

func _enter(data = {}):
	root.anim.play("Move")
	
func _step():
	super()
	if Global.player1.position.x < root.position.x:
		if root.is_on_floor():
			root.velocity.x = -root.speed
			root.velocity.y = 0
			root.velocity.y -= 400
	else:
		if root.is_on_floor():
			root.velocity.x = root.speed
			root.velocity.y = 0
			root.velocity.y -= 400



func _exit(next_state):
	super(next_state)
