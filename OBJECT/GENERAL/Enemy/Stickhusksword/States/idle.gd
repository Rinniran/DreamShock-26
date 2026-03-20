extends BaseState

func _enter(data = {}):
	if Global.player1.position.x < root.position.x:
		root.sprite.flip_h = false
	else:
		root.sprite.flip_h = true
	root.anim.play("Attack")
	
func _step():
	super()
	root.velocity.x = 0
	
	if parent.state_time >= 50:
		parent.change_state("Idle")


func _exit(next_state):
	super(next_state)
