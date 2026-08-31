extends BaseState

func _enter(data = {}):
	root.anim.play("Move")
	
func _step():
	super()
	
	
	if Global.player1.position.x < root.position.x:
		root.sprite.ls.rotation += 0.5
		root.sprite.flip_h = false
		if root.is_on_floor():
			root.velocity.x = -root.speed
			root.velocity.y = 0
			root.velocity.y -= 500
	else:
		root.sprite.ls.rotation += 0.5
		root.sprite.flip_h = true
		if root.is_on_floor():
			root.velocity.x = root.speed
			root.velocity.y = 0
			root.velocity.y -= 500



func _exit(next_state):
	super(next_state)
